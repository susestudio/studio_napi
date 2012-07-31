tools = require '../user'

unapi = tools.fileapi

describe 'User API', ->

  it 'gives users permitted to clone an appliance', (done) ->
    unapi GET '/appliances/:app/sharing', {app: 42}, async done, (err, r) ->
      no_error err
      contains r, appliance:
        id: '22'
        read_users: [
          'steam'
        ]

