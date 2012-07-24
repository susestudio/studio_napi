expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives API version', (done) ->
    unapi 'api_version', (err, r) ->
      no_error err
      contains r, version: '1.0'
      done()

