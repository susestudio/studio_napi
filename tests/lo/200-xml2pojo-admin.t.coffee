tools = require '../tools'
admin = require './lib-lo-admin'

transform = admin.transform
parse = tools.parse

describe 'XML -> POJO xforms, admin:', ->

  describe 'GET /about', ->
    it 'gives hostname, RoR env, git commitish', (done) ->
      parse "tests/admin/about.xml", async done, (err, r) ->
        no_error err
        r = transform 'GET /about', r
        contains r, about:
          server_name: 'kerogen.suse.de:3000'
          environment: 'development'
          git_revision: '074b2a42d48c7b8256c1b9328a7b29a944aeb8c7'

  describe 'GET /active_users', ->
    it 'gives build/testdrive data', (done) ->
      parse 'tests/admin/active_users.xml', async done, (err, r) ->
        no_error err
        r = transform 'GET /active_users', r
        contains r, active_users:
          since: '86400'
          users: []

  describe 'GET /job_history', ->
    it 'gives build/testdrive stats', (done) ->
      parse 'tests/admin/job_history.xml', async done, (err, r) ->
        no_error err
        r = transform 'GET /job_history', r
        contains r, job_history:
          since: '86400'
          builds:
            succeeded: '0'
            failed: '0'
            successrate: '0'
          testdrives: '0'

  describe 'GET /running_jobs', ->
    it 'gives build/testdrive data', (done) ->
      parse 'tests/admin/running_jobs.xml', async done, (err, r) ->
        no_error err
        r = transform 'GET /running_jobs', r
        contains r, running_jobs:
          builds: []
          testdrives: []

  describe 'GET /summary', ->
    it 'gives uptime, build/testdrive/user/bug stats, df, etc', (done) ->
      parse 'tests/admin/summary.xml', async done, (err, r) ->
        no_error err
        r = transform 'GET /summary', r
        contains r, summary:
          since: '86400'
          last_bug_status_refresh_time: {}
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

  describe 'GET /health_check', ->
    it 'gives information about the state of the system', (done) ->
      parse 'tests/admin/health_check.xml', async done, (err, r) ->
        no_error err
        r = transform 'GET /health_check', r
        contains r, health_check:
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

