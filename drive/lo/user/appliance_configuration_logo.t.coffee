tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'
  sess = studio.session user: creds

  urltpl = '/appliances/:app/configuration/logo'

  describe "GET #{urltpl}", ->

    it 'fails on nonexisting appliance', (done) ->

      sess GET urltpl, { app: 0 }, async done, (err, r) ->
        (expect err, 'error').to.have.property 'code', 'invalid_appliance_id'
        (expect err, 'error').to.have.property 'message'

    it 'succeeds on nonexisting appliance', (done) ->

      sess GET urltpl, { app: 1 }, async done, (err, r) ->

        no_error err
