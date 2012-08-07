{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /appliances/:app/status', ->

  it 'gives current state of an appliance', (done) ->
    parse 'tests/user/appliance_status.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /appliances/:app/status', r
      contains r, status:
        state: 'error'
        issues: [
          {
            type: 'error'
            text: 'You must include a kernel package in your appliance.'
            solution:
              type: 'install'
              package: 'kernel-default'
          }
        ]

