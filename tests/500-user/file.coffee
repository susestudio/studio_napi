tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'gives metadata for an overlay file', (done) ->
    unapi GET '/files/:file', async done, (err, r) ->
      no_error err
      contains r, file:
        id: '21'
        filename: 'api.txt'
        path: '/'
        owner: 'nobody'
        group: 'nobody'
        permissions: '644'
        enabled: 'true'
        download_url: 'http://susestudio.com/api/v1/user/files/21/data'

