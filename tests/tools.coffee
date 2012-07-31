fs = require 'fs'
xml = require '../lib/lo/xml'
expect = (require 'chai').expect
diff = (require 'difflet')(indent: 2, comment: true).compare

# FIXME: does not handle arrays well
contains = (actual, expected) ->
  for p, v of expected
    if v instanceof Object
      contains actual[p], v
    else
      (expect actual[p], diff actual, expected).to.equal v

no_error = (err) ->
  (expect err, 'err').to.not.exist

global.expect = expect

global.contains = contains
global.no_error = no_error

global.async = (done, test) -> (args...) ->
  test args...
  done()

filerpc = (dir, api2file) -> (httpmethod, apimethod, args..., done) ->
  file = api2file["#{httpmethod} #{apimethod}"] or apimethod[1..]
  fs.readFile "tests/#{dir}/#{file}.xml", done

exports.fileapi = (dir, api2file) ->
  (require "../lib/lo/#{dir}").api filerpc dir, api2file

exports.filerpc = filerpc
