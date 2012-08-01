for v in 'DELETE GET POST PUT'.split(' ')
  do (v) ->
    global[v] = (method, args..., done) -> [v, method, args..., done]

asis = (parsed) -> parsed

as_array = (parsed) ->
    if parsed instanceof Array
      parsed
    else
      [parsed]

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

exports.api = (methods) -> (rpc, xml) ->

  xml ?= (require './xml')

  (httpmethod, apimethod, args..., done) ->
    unless apimethod? and done?
      [httpmethod, apimethod, args..., done] = httpmethod
    sig = "#{httpmethod} #{apimethod}"

    unless methods[sig]
      return done "#{sig}: unknown method"

    rpc httpmethod, apimethod, args..., (err, data) ->
      return done err if err
      xml.parse data, (err, result) ->
        return done err if err
        root = methods[sig].root or apimethod
        result[root] = methods[sig].output result[root]
        done undefined, deattr result

url = require 'url'

exports.rpc = (urlprefix) -> (httpc, options) ->
  if not options?
    [httpc, options] = [(require './http').request, httpc]
  options = options.options
  parsed = url.parse options.url
  (httpmethod, apimethod, args..., done) ->
    if args.length
      apimethod = apimethod.replace /:(\w+)/g, (_, param) -> args[0][param]
    reqopts =
      method: httpmethod
      path: "#{urlprefix}#{apimethod}"
      port: parsed.port
      hostname: parsed.hostname
      auth: "#{options.user}:#{options.key}"
    httpc reqopts, done

