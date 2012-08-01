expect = (require 'chai').expect
tools = require './admin'
common = require '../lib/lo/common'
admin = require '../lib/lo/admin'

http = require 'http'
parseurl = (require 'url').parse
fs = require 'fs'
path = require 'path'

describe 'Admin API (HTTP RPC)', ->

  anapi = null
  server = null

  before (done) ->
    server = http.createServer (req, res) ->
      url = parseurl req.url
      pathname = path.basename url.pathname
      sig = "#{req.method} /#{pathname}"
      file = tools.api2file[sig]
      fs.readFile "tests/admin/#{file}.xml", (err, contents) ->
        done err if err
        res.end contents

    server.on 'error', done

    server.listen 0, 'localhost', (err) ->
      port = server.address().port
      anapi = admin.api common.rpc options:
        url: "http://localhost:#{port}/hello/dolly"
        user: 'roman-neuhauser'
        key: 'snafubar'

      done err

  after (done) ->
    server.on 'close', done
    server.close()

  describe '/about', ->
    it 'gives hostname, RoR env, git commitish', (done) ->
      anapi GET '/about', async done, (err, r) ->
        no_error err
        contains r, about:
          server_name: 'kerogen.suse.de:3000'
          environment: 'development'
          git_revision: '074b2a42d48c7b8256c1b9328a7b29a944aeb8c7'

  describe '/active_users', ->
    it 'gives build/testdrive data', (done) ->
      anapi GET '/active_users', async done, (err, r) ->
        no_error err
        contains r, active_users:
          since: '86400'
          users: []

  describe '/job_history', ->
    it 'gives build/testdrive stats', (done) ->
      anapi GET '/job_history', async done, (err, r) ->
        no_error err
        contains r, job_history:
          since: '86400'
          builds:
            succeeded: '0'
            failed: '0'
            successrate: '0'
          testdrives: '0'

  describe '/running_jobs', ->
    it 'gives build/testdrive data', (done) ->
      anapi GET '/running_jobs', async done, (err, r) ->
        no_error err
        contains r, running_jobs:
          builds: []
          testdrives: []

  describe '/summary', ->
    it 'gives uptime, build/testdrive/user/bug stats, df, etc', (done) ->
      anapi GET '/summary', async done, (err, r) ->
        no_error err
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

  describe '/health_check', ->
    it 'gives information about the state of the system', (done) ->
      anapi GET '/health_check', {runner_threshold: 75}, async done, (err, r) ->
        no_error err
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

