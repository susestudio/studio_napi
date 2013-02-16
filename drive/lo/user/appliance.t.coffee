tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'
  sess = studio.session user: creds

  describe 'GET /appliances/:app', ->

    it 'fails on nonexisting appliance', (done) ->

      sess GET '/appliances/:app', { app: 0 }, async done, (err, r) ->
        (expect err, 'error').to.have.property 'code', 'invalid_appliance_id'
        (expect err, 'error').to.have.property 'message'

    it 'works with existing template', (done) ->

      sess GET '/appliances/:app', { app: 1 }, async done, (err, r) ->

        no_error err
        (expect r, 'appliance').to.have.keys 'appliance'
        r = r.appliance
        (expect r, 'appliance').to.have.keys \
          'arch'
        , 'basesystem'
        , 'builds'
        , 'edit_url'
        , 'estimated_compressed_size'
        , 'estimated_raw_size'
        , 'id'
        , 'last_edited'
        , 'name'
        , 'type'
        , 'uuid'

        # templates are not built
        (expect r.builds, 'builds').to.be.an.empty 'array'

        return

        # documentation
        (expect r.parent, 'parent').to.have.keys 'id', 'name'

        for b in r.builds
          (expect b, 'build').to.have.keys \
            'compressed_image_size'
          , 'download_url'
          , 'id'
          , 'image_size'
          , 'image_type'
          , 'version'

