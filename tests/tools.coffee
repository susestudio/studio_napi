fs = require 'fs'
xml = require '../lib/xml'
expect = (require 'chai').expect

# FIXME: does not handle arrays well
contains = (actual, expected) ->
  for p, v of expected
    if v instanceof Object
      contains actual[p], v
    else
      (expect actual[p], p).to.equal v

no_error = (err) ->
  (expect err, 'err').to.equal undefined

global.expect = expect

global.contains = contains
global.no_error = no_error

global.async = (done, test) -> (args...) ->
  test args...
  done()

exports.rpc = rpc = (dir) -> (httpmethod, apimethod, done) ->
  fs.readFile "tests/#{dir}/#{apimethod}.xml", done

exports.api = (dir) ->
  (require "../lib/#{dir}").api rpc dir

