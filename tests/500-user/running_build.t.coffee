{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /running_builds/:bld', ->

  it 'gives status of a running build', (done) ->
    parse 'tests/user/running_build.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /running_builds/:bld', r
      contains r, running_build:
        id: '38'
        state: 'running'
        percent: '0'
        time_elapsed: '5'
        message: 'Fetching appliance configuration'

