xml = require './xml'

global.GET = (method, done) -> ['get', method, done]

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

exports.api = (methods, roots) -> (rpc) -> (httpmethod, apimethod, done) ->
  unless apimethod? and done?
    [httpmethod, apimethod, done] = httpmethod
  unless methods[apimethod]
    return done "#{apimethod}: unknown method"
  else
    rpc httpmethod, apimethod, (err, data) ->
      return done err if err
      xml.parse data, (err, result) ->
        return done err if err
        root = roots[apimethod] or apimethod
        result[root] = methods[apimethod] result[root]
        done undefined, deattr result

