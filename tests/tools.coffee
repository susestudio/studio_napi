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

api2file =
  'GET /about': 'about'
  'GET /account': 'account'
  'GET /active_users': 'active_users'
  'GET /appliances': 'appliances'
  'GET /appliances/:app': 'appliance'
  'GET /appliances/:app/configuration': 'configuration'
  'GET /appliances/:app/gpg_key/:key': 'gpg_key'
  'GET /appliances/:app/gpg_keys': 'gpg_keys'
  'GET /appliances/:app/sharing': 'sharing'
  'GET /appliances/:app/software': 'software'
  'GET /appliances/:app/status': 'appliance_status'
  'GET /builds': 'builds'
  'GET /builds/:bld': 'build'
  'GET /files': 'files'
  'GET /files/:file': 'file'
  'GET /health_check': 'health_check'
  'GET /job_history': 'job_history'
  'GET /repositories': 'repositories'
  'GET /repositories/:repo': 'repository'
  'GET /rpms': 'rpms'
  'GET /rpms/:rpm': 'rpm'
  'GET /running_builds': 'running_builds'
  'GET /running_builds/:bld': 'running_build'
  'GET /running_jobs': 'running_jobs'
  'GET /summary': 'summary'
  'GET /testdrives': 'testdrives'
  'POST /testdrives': 'testdrive'

exports.rpc = rpc = (dir) -> (httpmethod, apimethod, args..., done) ->
  file = api2file["#{httpmethod} #{apimethod}"] or apimethod[1..]
  fs.readFile "tests/#{dir}/#{file}.xml", done

exports.api = (dir) ->
  (require "../lib/#{dir}").api rpc dir

