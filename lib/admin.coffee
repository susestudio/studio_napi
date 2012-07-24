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

roots = {}

methods =
  about: asis
  active_users: since

  health_check: (parsed) ->
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

  job_history: since
  running_jobs: asis

  summary: (parsed) ->
    unless parsed.disks instanceof Array
      parsed.disks = [parsed.disks.disk]
    else
      parsed.disks = (disk for disk in parsed.disks['#'])
    since parsed

exports.api = common.api 'admin', methods, roots
