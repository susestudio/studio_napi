tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'gives current state of an appliance', (done) ->
    unapi GET '/appliances/:app/status', {app: 42}, async done, (err, r) ->
      no_error err
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

