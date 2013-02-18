tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  sess = studio.session user: tools.config_file 'cfg/user'

  describe '/builds?appliance_id=<id>', ->

    it 'requires appliance_id', (done) ->

      sess GET '/builds', async done, (err, r) ->
        (expect err, 'error').to.have.property 'code', 'missing_appliance_id'
        (expect err, 'error').to.have.property 'message'

    it 'requires id of an existing appliance', (done) ->

      sess GET '/builds', { appliance_id: 0 }, async done, (err, r) ->
        (expect err, 'error').to.have.property 'code', 'invalid_appliance_id'
        (expect err, 'error').to.have.property 'message'

    it 'reports builds of given appliance', (done) ->

      return do done

      # FIXME successful roundtrip from appliance creation
      # FIXME to GET /builds?appliance_id=:app is too involved for now

      sess GET '/builds', { appliance_id: 1 }, async done, (err, r) ->
        no_error err

        common = [
          'completed_at'
          'compressed_image_size'
          'created_at'
          'expired'
          'id'
          'image_type'
          'size'
          'started_at'
          'state'
          'version'
        ]
        (expect r, 'result').to.have.keys 'builds'
        (expect r.builds, 'builds').to.be.an 'array'

        for b in r.builds
          keys = common.concat \
            switch b.state
              when 'finished' then ['checksum', 'download_url']
              else []
          (expect b, 'build').to.have.keys keys

          if b.state is 'finished'
            (expect b.checksum, 'checksum').to.have.keys \
              'md5'
            , 'sha1'

