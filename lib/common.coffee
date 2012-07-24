fs = require 'fs'
xml = require './xml'

asis = (parsed) -> parsed

as_array = (parsed) ->
    if parsed instanceof Array
      parsed
    else
      [parsed]

exports.asis = asis
exports.as_array = as_array

exports.api = (dir, methods, roots) -> (method, args..., done) ->
  unless methods[method]
    return done "#{method}: unknown method"
  else
    fs.readFile "tests/#{dir}/#{method}.xml", (err, data) ->
      return done err if err
      xml.parse data, (err, result) ->
        return done err if err
        root = roots[method] or method
        result[root] = methods[method] result[root]
        done undefined, result

