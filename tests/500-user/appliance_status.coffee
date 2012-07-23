expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives current state of an appliance', (done) ->
    unapi 'appliance_status', (err, r) ->
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
      done()

