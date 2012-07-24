tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives current state of an appliance', (done) ->
    unapi GET 'appliance_status', async done, (err, r) ->
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

