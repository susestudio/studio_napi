common = require './common'

asis = common.asis
as_array = common.as_array

since = (parsed) ->
  parsed.since = parsed.since['#']
  parsed

runners = (parsed, kind) ->
  unless parsed["#{kind}s"] instanceof Array
    parsed["#{kind}s"] = [parsed["#{kind}s"][kind]]
  parsed

roots =
  'GET /about': 'about'
  'GET /active_users': 'active_users'
  'GET /health_check': 'health_check'
  'GET /job_history': 'job_history'
  'GET /running_jobs': 'running_jobs'
  'GET /summary': 'summary'

methods =
  'GET /about': asis
  'GET /active_users': since

  'GET /health_check': (parsed) ->
    runners parsed, 'kiwi_runner'
    runners parsed, 'testdrive_runner'
    unless parsed.disks instanceof Array
      if parsed.disks.disk instanceof Array
        parsed.disks = parsed.disks.disk
      else
        parsed.disks = [parsed.disks.disk]
    disks = []
    for d in parsed.disks
      d.path = d['@'].path
      delete d['@']
      disks.push d
    parsed

  'GET /job_history': since

  'GET /running_jobs': asis

  'GET /summary': (parsed) ->
    unless parsed.disks instanceof Array
      parsed.disks = [parsed.disks.disk]
    else
      parsed.disks = (disk for disk in parsed.disks['#'])
    since parsed

exports.api = common.api methods, roots
