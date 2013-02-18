common = require './common'

asis = common.asis
to_array = common.to_array

since = (parsed) ->
  parsed.since = parsed.since['#']
  parsed

transforms =
  'GET /about':
    root: 'about'
    output: asis

  'GET /active_users':
    root: 'active_users'
    output: (parsed) ->
      day: parsed.day
      total: parsed.total
      groups: parsed.groups.group

  'GET /health_check':
    root: 'health_check'
    output: (parsed) ->
      to_array parsed, 'kiwi_runner'
      to_array parsed, 'testdrive_runner'
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
    output: (parsed) ->
      to_array parsed, 'build'
      to_array parsed, 'testdrive'
      parsed

  'GET /summary':
    root: 'summary'
    output: (parsed) ->
      unless parsed.disks instanceof Array
        parsed.disks = [parsed.disks.disk]
      else
        parsed.disks = (disk for disk in parsed.disks['#'])
      since parsed

exports.api = common.api transforms
exports.transform = common.transform transforms

