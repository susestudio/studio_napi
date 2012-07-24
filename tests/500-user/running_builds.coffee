expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives status of all running build of an appliance', (done) ->
    unapi GET 'running_builds', (err, r) ->
      no_error err
      contains r, running_builds: [
        {
          id: '38'
          state: 'running'
          percent: '0'
          time_elapsed: '5'
          message: 'Fetching appliance configuration'
        }
      ]
      done()

