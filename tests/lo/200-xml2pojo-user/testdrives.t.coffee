{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /testdrives', ->

  it 'lists running testdrives for current user', (done) ->
    parse 'tests/user/GET_testdrives.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /testdrives', r
      contains r, testdrives: [
        {
          id: '4'
          state: 'running'
          build_id: '22'
        }
      ]

