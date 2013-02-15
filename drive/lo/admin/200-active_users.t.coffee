tools = require './tools'
studio = require './lib-lo'

describe 'Low-level admin API:', ->

  creds = tools.config_file 'cfg/admin'

  responds_to 'GET /active_users', (done) ->
    sess = studio.session admin: creds
    sess GET '/active_users', async done, (e, r) ->
      no_error e
      (expect r).to.have.keys 'active_users'
      r = r.active_users
      (expect r, 'active_users').to.have.keys \
        'day'
      , 'groups'
      , 'total'
      for g in r.groups
        (expect g, 'group').to.have.keys 'name', 'value'

