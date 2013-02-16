tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'

  responds_to 'GET /appliances', (done) ->
    sess = studio.session user: creds
    sess GET '/appliances', async done, (err, r) ->

      no_error err
      (expect r, 'appliances').to.have.keys 'appliances'
      (expect r.appliances, 'appliances').to.be.an 'array'
      for a in r.appliances
        (expect a, 'appliance').to.have.keys \
          'arch'
        , 'basesystem'
        , 'builds'
        , 'edit_url'
        , 'estimated_compressed_size'
        , 'estimated_raw_size'
        , 'id'
        , 'last_edited'
        , 'name'
        , 'parent'
        , 'type'
        , 'uuid'

