expect = (require 'chai').expect
#sinon = (require 'sinon')
anapi = (require '../lib/admin').api

# FIXME: does not handle arrays well
contains = (actual, expected) ->
  for p, v of expected
    if v instanceof Object
      contains actual[p], v
    else
      (expect actual[p], p).to.equal v

no_error = (err) ->
  (expect err, 'err').to.equal undefined

describe 'Admin API', ->

  describe 'about', ->
    it 'should give hostname, RoR env, git commitish', (done) ->
      anapi 'about', (err, r) ->
        no_error err
        contains r, {
          server_name: 'kerogen.suse.de:3000'
          environment: 'development'
          git_revision: '074b2a42d48c7b8256c1b9328a7b29a944aeb8c7'
        }
        done()

  describe 'active_users', ->
    it 'should give build/testdrive data', (done) ->
      anapi 'active_users', (err, r) ->
        no_error err
        contains r, {
          since: '86400'
          users: []
        }
        done()

  describe 'job_history', ->
    it 'should give build/testdrive stats', (done) ->
      anapi 'job_history', (err, r) ->
        no_error err
        contains r, {
          since: '86400'
          builds:
            succeeded: '0'
            failed: '0'
            successrate: '0'
          testdrives: '0'
        }
        done()

  describe 'running_jobs', ->
    it 'should give build/testdrive data', (done) ->
      anapi 'running_jobs', (err, r) ->
        no_error err
        contains r, {
          builds: []
          testdrives: []
        }
        done()

  describe 'summary', ->
    it 'should give uptime, build/testdrive/user/bug stats, df, etc', (done) ->
      anapi 'summary', (err, r) ->
        no_error err
        contains r, {
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
        }
        done()

  describe 'health_check', ->
    it 'should give crap', (done) ->
      anapi 'health_check', (err, r) ->
        no_error err
        contains r, {
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
        }
        done()
