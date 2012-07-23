fs = require 'fs'
xml = require './xml'

asis = (parsed) -> parsed
as_array = (parsed) ->
    if parsed instanceof Array
      parsed
    else
      [parsed]

roots =
  appliance_status: 'status'

methods =
  account: (xo) ->
    xo.openid_urls = as_array xo.openid_urls.openid_url
    xo

  appliance: (xo) ->
    xo.builds = as_array xo.builds.build
    xo

  appliance_status: (xo) ->
    xo.issues = as_array xo.issues.issue
    xo

  appliances: (xo) ->
    xo = as_array xo.appliance
    for a in xo
      a.builds = as_array a.builds.build
    xo

  build: asis

  builds: (xo) ->
    xo = as_array xo.build
    xo

exports.api = (method, args..., done) ->
  unless methods[method]
    return done "#{method}: unknown method"
  else
    fs.readFile "tests/user/#{method}.xml", (err, data) ->
      return done err if err
      xml.parse data, (err, result) ->
        return done err if err
        root = roots[method] or method
        result[root] = methods[method] result[root]
        done undefined, result

