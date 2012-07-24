expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives information about all uploaded rpms for a base system', (done) ->
    unapi GET 'rpms', (err, r) ->
      no_error err
      contains r, rpms: {
        base_system: 'SLED11'
        rpms: [
          {
            id: '54'
            filename: 'fate-1.3.10-14.3.i586.rpm'
            size: '587500'
            archive: 'false'
            base_system: 'SLED11'
          }
        ]
      }
      done()

