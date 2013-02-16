tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'

  responds_to 'GET /account', (done) ->
    sess = studio.session user: creds
    sess GET '/account', async done, (e, r) ->
      no_error e
      (expect r, 'account').to.have.keys 'account'
      r = r.account
      (expect r, 'account').to.have.keys \
        'created_at'
      , 'disk_quota'
      , 'displayname'
      , 'email'
      , 'openid_urls'
      , 'username'

      (expect r.openid_urls, 'openid_urls').to.be.an 'array'
      (expect r.disk_quota, 'disk_quota').to.have.keys \
        'available'
      , 'used'

