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
  unless parsed[kinds] instanceof Array
    if parsed[kinds][kind] is undefined
      parsed[kinds] = []
    else if parsed[kinds][kind] instanceof Array
      parsed[kinds] = parsed[kinds][kind]
    else
      parsed[kinds] = [parsed[kinds][kind]]
  parsed

deattr = (xo) ->
  if xo instanceof Array
    for v, i in xo
      deattr v
  else if xo instanceof Object
    delete xo['@']
    for p, v of xo
      deattr v
  xo

exports.asis = asis
exports.as_array = as_array
exports.to_array = to_array

transform = (transforms) -> (sig, result) ->
  t = transforms[sig]
  result[t.root] = t.output result[t.root]
  deattr result

exports.transform = transform

exports.api = (methods) -> (rpc, xml) ->

  xml ?= (require './xml')

  xml2pojo = transform methods

  (httpmethod, apimethod, args..., done) ->
    unless apimethod? and done?
      # FIXME: coverage
      [httpmethod, apimethod, args..., done] = httpmethod
    sig = "#{httpmethod} #{apimethod}"

    unless methods[sig]
      return done new Error "#{sig}: unknown method"

    rpc httpmethod, apimethod, args..., (err, data) ->
      return done err if err
      xml.parse data, (err, result) ->
        # FIXME: coverage
        return done err if err
        return done result.error if result.error and result.error.code
        done undefined, xml2pojo sig, result

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

