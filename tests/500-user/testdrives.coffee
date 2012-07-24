expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'lists running testdrives for current user', (done) ->
    unapi GET 'testdrives', (err, r) ->
      no_error err
      contains r, testdrives: [
        {
          id: '4'
          state: 'running'
          build_id: '22'
        }
      ]
      done()
  
