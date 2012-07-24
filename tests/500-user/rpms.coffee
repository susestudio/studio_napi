expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives information about all uploaded rpms for a base system', (done) ->
    unapi 'rpms', (err, r) ->
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

