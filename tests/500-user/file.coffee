expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives metadata for an overlay file', (done) ->
    unapi GET 'file', (err, r) ->
      no_error err
      contains r, file: {
        id: '21'
        filename: 'api.txt'
        path: '/'
        owner: 'nobody'
        group: 'nobody'
        permissions: '644'
        enabled: 'true'
        download_url: 'http://susestudio.com/api/v1/user/files/21/data'
      }
      done()

