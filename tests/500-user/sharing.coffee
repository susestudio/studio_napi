expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives users permitted to clone an appliance', (done) ->
    unapi 'sharing', (err, r) ->
      no_error err
      contains r, appliance: {
        id: '22'
        read_users: [
          'steam'
        ]
      }
      done()

