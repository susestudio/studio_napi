tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives information about an uploaded rpm', (done) ->
    unapi GET 'rpm', async done, (err, r) ->
      no_error err
      contains r, rpm: {
        id: '54'
        filename: 'fate-1.3.10-14.3.i586.rpm'
        size: '587500'
        archive: 'false'
        base_system: 'SLED11'
      }

