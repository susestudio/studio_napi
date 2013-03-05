{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /appliances/:app/sharing', ->

  it 'gives users permitted to clone an appliance', (done) ->
    parse 'tests/user/GET_sharing.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /appliances/:app/sharing', r
      contains r, appliance:
        id: '22'
        read_users: [
          'steam'
        ]

