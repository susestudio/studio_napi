tools = require '../user'

unapi = tools.fileapi

describe 'User API', ->

  it 'gives API version', (done) ->
    unapi GET '/api_version', async done, (err, r) ->
      no_error err
      contains r, version: '1.0'

