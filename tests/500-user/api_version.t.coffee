tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'gives API version', (done) ->
    unapi GET '/api_version', async done, (err, r) ->
      no_error err
      contains r, version: '1.0'

