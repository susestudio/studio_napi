expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'lists running testdrives for current user', (done) ->
    unapi 'testdrives', (err, r) ->
      no_error err
      contains r, testdrives:[
        {
          id: '4'
          state: 'running'
          build_id: '22'
        }
      ]
      done()
  
