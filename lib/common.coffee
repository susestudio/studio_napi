xml = require './xml'

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

exports.api = (methods, roots) -> (rpc) -> (httpmethod, apimethod, args..., done) ->
  unless apimethod? and done?
    [httpmethod, apimethod, args..., done] = httpmethod
  sig = "#{httpmethod} #{apimethod}"
  unless methods[sig]
    return done "#{sig}: unknown method"
  else
    rpc httpmethod, apimethod, (err, data) ->
      return done err if err
      xml.parse data, (err, result) ->
        return done err if err
        root = roots[sig] or apimethod
        result[root] = methods[sig] result[root]
        done undefined, deattr result

