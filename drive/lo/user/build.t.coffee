tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'

  responds_to 'GET /builds/:bld', (done) ->
    sess = studio.session user: creds
    sess GET '/builds/:bld', {bld: 0}, async done, (err, r) ->
      (expect err, 'error').to.have.property 'code', 'invalid_build_id'
      (expect err, 'error').to.have.property 'message'

      return

      # FIXME successful roundtrip from appliance creation
      # FIXME to GET /appliances/:app is too involved for now

      no_error err
      r = r.build
      (expect r, 'build').to.have.keys \
        'checksum'
      , 'completed_at'
      , 'compressed_image_size'
      , 'created_at'
      , 'download_url'
      , 'expired'
      , 'id'
      , 'image_type'
      , 'log'
      , 'profile'
      , 'size'
      , 'started_at'
      , 'state'
      , 'version'

      (expect r.checksum, 'checksum').to.have.keys 'md5', 'sha1'

      (expect r.log, 'build.log').to.have.keys 'build', 'kiwi'

      (expect r.profile, 'build.profile').to.have.keys 'steps'
      (expect r.profile.steps, 'build.profile.steps').to.be.an 'array'

