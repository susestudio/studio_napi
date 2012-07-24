expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives status of a running build', (done) ->
    unapi GET 'running_build', (err, r) ->
      no_error err
      contains r, running_build: {
        id: '38'
        state: 'running'
        percent: '0'
        time_elapsed: '5'
        message: 'Fetching appliance configuration'
      }
      done()

