{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /rpms', ->

  it 'gives information about all uploaded rpms for a base system', (done) ->
    parse 'tests/user/GET_rpms.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /rpms', r
      contains r, rpms:
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

