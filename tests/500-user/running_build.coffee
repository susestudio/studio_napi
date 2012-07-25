tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'gives status of a running build', (done) ->
    unapi GET '/running_builds/:bld', {app: 42}, async done, (err, r) ->
      no_error err
      contains r, running_build: {
        id: '38'
        state: 'running'
        percent: '0'
        time_elapsed: '5'
        message: 'Fetching appliance configuration'
      }

