{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /rpms/:rpm', ->

  it 'gives information about an uploaded rpm', (done) ->
    parse 'tests/user/rpm.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /rpms/:rpm', r
      contains r, rpm:
        id: '54'
        filename: 'fate-1.3.10-14.3.i586.rpm'
        size: '587500'
        archive: 'false'
        base_system: 'SLED11'

