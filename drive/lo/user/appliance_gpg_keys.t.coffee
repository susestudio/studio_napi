tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'
  sess = studio.session user: creds

  it 'requires existing appliance', (done) ->
    sess GET '/appliances/:app/gpg_keys', {app: 0}, async done, (e, r) ->
      (expect e, 'error').to.have.property 'code', 'invalid_appliance_id'
      (expect e, 'error').to.have.property 'message'

  responds_to 'GET /appliances/:app/gpg_keys', (done) ->
    sess GET '/appliances/:app/gpg_keys', {app: 1}, async done, (e, r) ->
      no_error e
      (expect r).to.have.keys 'gpg_keys'
      (expect r.gpg_keys).to.be.an.empty 'array'

