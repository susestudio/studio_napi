expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives status of a running build', (done) ->
    unapi GET 'running_build', async done, (err, r) ->
      no_error err
      contains r, running_build: {
        id: '38'
        state: 'running'
        percent: '0'
        time_elapsed: '5'
        message: 'Fetching appliance configuration'
      }

