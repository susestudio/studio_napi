tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'

  responds_to 'GET /template_sets', (done) ->
    sess = studio.session user: creds
    sess GET '/template_sets', async done, (err, r) ->

      no_error err
      (expect r, 'template_sets').to.have.keys 'template_sets'
      (expect r.template_sets, 'template_sets').to.be.an 'array'
      for ts in r.template_sets
        (expect ts, 'template').to.have.keys \
          'description'
        , 'name'
        , 'templates'
        (expect ts.templates, 'templates').to.be.an 'array'
        for t in ts.templates
          (expect t, 'template').to.be.an 'object'
          (expect t, 'template').to.have.keys \
            'appliance_id'
          , 'basesystem'
          , 'description'
          , 'name'
          (expect t.appliance_id, 'appliance_id').to.match /^\d+$/
          (expect t.basesystem, 'basesystem').to.match /^\S+$/
          (expect t.name, 'name').to.not.be.empty
