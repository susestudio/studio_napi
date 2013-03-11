for v in 'DELETE GET POST PUT'.split(' ')
  do (v) ->
    global[v] = (method, args..., done) -> [v, method, args..., done]

asis = (parsed) -> parsed

as_array = (parsed) ->
    if parsed instanceof Array
      parsed
    else if parsed is undefined
      []
    else
      [parsed]

to_array = (parsed, kind) ->
  kinds = "#{kind}s"
  return parsed unless kinds of parsed
  unless parsed[kinds] instanceof Array
    if parsed[kinds][kind] is undefined
      parsed[kinds] = []
    else if parsed[kinds][kind] instanceof Array
      parsed[kinds] = parsed[kinds][kind]
    else
      parsed[kinds] = [parsed[kinds][kind]]
  parsed

exports.asis = asis
exports.as_array = as_array
exports.to_array = to_array

exports.api = (methods) -> (rpc, xml) ->

  xml ?= (require './xml')

  xml2pojo = xml.transform methods

  response_handlers =
    'application/xml': (sig) -> (res, done) ->
      body = new Buffer 0
      res.on 'data', (chunk) ->
        body = Buffer.concat [body, chunk]
      res.on 'end', ->
        xml.parse body, (err, result) ->
          return done err if err
          return done result.error if result.error and result.error.code
          done undefined, xml2pojo sig, result
    '*/*': (sig) -> (res, done) ->
      done undefined, res

  (httpmethod, apimethod, args..., done) ->
    unless apimethod? and done?
      # FIXME: coverage
      [httpmethod, apimethod, args..., done] = httpmethod
    sig = "#{httpmethod} #{apimethod}"

    unless methods[sig]
      return done new Error "#{sig}: unknown method"

    rpc httpmethod, apimethod, args..., (err, res) ->
      return done err if err
      ct = res.headers['content-type'].match(/^[^;$]+/)[0]
      ct = '*/*' unless ct of response_handlers
      rh = response_handlers[ct] sig
      rh res, done

{url, qstring} = require './url'

exports.rpc = (httpc, options) ->
  if not options?
    # FIXME: coverage
    [httpc, options] = [(require './http').request, httpc]
  options = options.options
  server = url.parse options.url
  (httpmethod, apimethod, args..., done) ->
    qs = ''
    if args.length
      inpath = {}
      apimethod = apimethod.replace /:(\w+)/g, (_, param) ->
        inpath[param] = yes
        qstring.escape args[0][param]
      query = {}
      query[k] = v for k, v of args[0] when not inpath[k]
      qs = qstring.stringify query
      qs = "?#{qs}" if qs.length
    reqopts =
      method: httpmethod
      path: "#{server.pathname}#{apimethod}#{qs}"
      port: server.port
      hostname: server.hostname
      auth: "#{options.user}:#{options.key}"
    httpc reqopts, done

