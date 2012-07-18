exports.api = (method, args..., done) ->
  data =
    about:
      server_name: 'kerogen.suse.de:3000'
      environment: 'development'
      git_revision: '074b2a42d48c7b8256c1b9328a7b29a944aeb8c7'

    active_users:
      since: '86400'
      users: []

    health_check:
      state: 'error'
      mysql: 'ok'
      thoth: 'ok'
      rmds: 'ok'
      kiwi_runners: [
        {
          id: '1'
          address: 'localhost:3001'
          status: 'pinged'
          last_pinged: '2009-07-16 09:27:32 UTC'
          slots: '1'
          used_slots: '0'
          load: '2.68'
        }
      ]
      testdrive_runners: [
        {
          id: '2'
          address: 'localhost:3002'
          status: 'unreachable'
          last_pinged: '2009-06-25 14:21:02 UTC'
          slots: '8'
          used_slots: '0'
          load: '0.34'
        }
      ]
      disks: [
        {
          path: '/'
          used: '61%'
          available: '7999651840'
        }
        {
          path: '/dev'
          used: '1%'
          available: '1038233600'
        }
      ]

    job_history:
      since: '86400'
      builds:
        succeeded: '0'
        failed: '0'
        successrate: '0'
      testdrives: '0'

    summary:
      since: '86400'
      last_bug_status_refresh_time: undefined
      unassigned_failures_count: '10'
      builds:
        succeeded: '0'
        failed: '0'
        errored: '0'
        successrate: '0'
      testdrives: '0'
      active_users: []
      disks: [
        {
          filesystem: '/dev/sda7'
          total: '121449922560'
          used: '104339582976'
          used_percentage: '91%'
          available: '10940973056'
          mount_point: '/build'
        }
      ]
      bugs: []

    running_jobs:
      builds: []
      testdrives: []

  if data[method] is undefined
    done "#{method}: unknown method"
  else
    done undefined, data[method]

