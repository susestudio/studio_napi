tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'lists running testdrives for current user', (done) ->
    unapi GET 'testdrives', async done, (err, r) ->
      no_error err
      contains r, testdrives: [
        {
          id: '4'
          state: 'running'
          build_id: '22'
        }
      ]
  
