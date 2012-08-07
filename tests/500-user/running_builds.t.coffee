{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /running_builds', ->

  it 'gives status of all running build of an appliance', (done) ->
    parse 'tests/user/running_builds.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /running_builds', r
      contains r, running_builds: [
        {
          id: '38'
          state: 'running'
          percent: '0'
          time_elapsed: '5'
          message: 'Fetching appliance configuration'
        }
      ]

