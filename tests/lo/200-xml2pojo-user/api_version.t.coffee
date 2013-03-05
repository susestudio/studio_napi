{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /api_version', ->

  it 'gives API version', (done) ->
    parse 'tests/user/GET_api_version.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /api_version', r
      contains r, version: '1.0'

