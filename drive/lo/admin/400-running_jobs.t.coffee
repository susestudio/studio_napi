tools = require './tools'
studio = require './lib-lo'

describe 'Low-level admin API:', ->

  creds = tools.config_file 'cfg/admin'

  responds_to 'GET /running_jobs', (done) ->
    sess = studio.session admin: creds
    sess GET '/running_jobs', (e, r) ->
      no_error e
      (expect r).to.have.keys 'running_jobs'
      r = r.running_jobs
      (expect r).to.have.keys 'builds', 'testdrives'

      (expect r.builds, 'builds').to.be.an 'array'
      (expect r.testdrives, 'testdrives').to.be.an 'array'

      for b in r.builds
        (expect b).to.have.keys \
          'appliance_id'
        , 'author'
        , 'base_system'
        , 'created'
        , 'duration'
        , 'format'
        , 'image_id'
        , 'job_type'
        , 'name'
        , 'runner'
        , 'started'
        , 'state'

      for t in r.testdrives
        (expect t).to.have.keys \
          'name'
        , 'appliance_id'
        , 'image_id'
        , 'format'
        , 'author'
        , 'started'
        , 'runner'

      done()

