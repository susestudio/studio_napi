tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'

  responds_to 'GET /api_version', (done) ->
    sess = studio.session user: creds
    sess GET '/api_version', async done, (e, r) ->
      no_error e
      (expect r, 'version').to.have.keys 'version'
      (expect r.version).to.match /^2\.\d/

