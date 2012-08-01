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

methods =
  'GET /about':
    root: 'about'
    output: asis

  'GET /active_users':
    root: 'active_users'
    output: since

  'GET /health_check':
    root: 'health_check'
    output: (parsed) ->
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

  'GET /job_history':
    root: 'job_history'
    output: since

  'GET /running_jobs':
    root: 'running_jobs'
    output: asis

  'GET /summary':
    root: 'summary'
    output: (parsed) ->
      unless parsed.disks instanceof Array
        parsed.disks = [parsed.disks.disk]
      else
        parsed.disks = (disk for disk in parsed.disks['#'])
      since parsed

exports.api = common.api methods

