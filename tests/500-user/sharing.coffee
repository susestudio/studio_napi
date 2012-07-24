tools = require '../tools'

unapi = tools.api 'user'

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

