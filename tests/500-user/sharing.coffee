expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives users permitted to clone an appliance', (done) ->
    unapi GET 'sharing', async done, (err, r) ->
      no_error err
      contains r, appliance: {
        id: '22'
        read_users: [
          'steam'
        ]
      }

