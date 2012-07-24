expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives information about the account', (done) ->
    unapi GET 'account', async done, (err, r) ->
      no_error err
      contains r, account: {
        username: 'uexample'
        displayname: 'User Example'
        email: 'user@example.com'
        created_at: '2009-05-14 14:51:07 UTC'
        openid_urls: [
          'http://user.example.com/'
        ]
        disk_quota:
          available: '15GB'
          used: '4%'
      }

