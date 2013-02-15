tools = require './tools'
studio = require './lib-lo'

describe 'Low-level admin API:', ->

  creds = tools.config_file 'cfg/admin'

  responds_to 'GET /about', (done) ->
    sess = studio.session admin: creds
    sess GET '/about', (e, r) ->
      no_error e
      (expect r).to.have.keys 'about'
      (expect r.about).to.have.keys \
        'server_name'
      , 'environment'
      , 'git_revision'
      do done

