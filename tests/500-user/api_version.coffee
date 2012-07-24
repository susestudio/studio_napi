expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives API version', (done) ->
    unapi GET 'api_version', async done, (err, r) ->
      no_error err
      contains r, version: '1.0'

