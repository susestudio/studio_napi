tools = require './tools'
studio = require './lib-lo'

describe 'Low-level admin API:', ->

  creds = tools.config_file 'cfg/admin'

  responds_to 'GET /health_check', (done) ->
    sess = studio.session admin: creds
    sess GET '/health_check', (e, r) ->
      no_error e
      (expect r).to.have.keys 'health_check'
      r = r.health_check
      (expect r).to.have.keys \
        'delayed_jobs'
      , 'disks'
      , 'kiwi_runners'
      , 'mysql'
      , 'queue_length'
      , 'sid'
      , 'state'
      , 'testdrive_runners'

      (expect r.state).to.match /ok/
      (expect r.mysql).to.match /ok/
      (expect r.sid).to.match /ok/
      (expect r.queue_length).to.match /\d/
      (expect r.delayed_jobs).to.match /\d/

      (expect r.kiwi_runners).to.be.an 'array'
      (expect r.testdrive_runners).to.be.an 'array'
      (expect r.disks).to.be.an 'array'

      runners =
        kiwi_runner: r.kiwi_runners
        testdrive_runner: r.testdrive_runners

      for desc, set in runners
        for runner in set
          (expect runner, desc).to.have.keys \
            'address'
          , 'id'
          , 'last_pinged'
          , 'load'
          , 'slots'
          , 'status'
          , 'used_slots'

      # FIXME: appears to be broken in studio, `r.disks` is an empty array
      #for disk in r.disks
      #  ...
      do done

