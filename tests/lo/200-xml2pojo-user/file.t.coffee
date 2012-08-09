{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /files/:file', ->

  it 'gives metadata for an overlay file', (done) ->
    parse 'tests/user/file.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /files/:file', r
      contains r, file:
        id: '21'
        filename: 'api.txt'
        path: '/'
        owner: 'nobody'
        group: 'nobody'
        permissions: '644'
        enabled: 'true'
        download_url: 'http://susestudio.com/api/v1/user/files/21/data'

