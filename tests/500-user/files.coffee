tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives metadata for all overlay files in an appliance', (done) ->
    unapi GET 'files', async done, (err, r) ->
      no_error err
      contains r, files: [
        {
          id: '21'
          filename: 'api.txt'
          path: '/'
          owner: 'nobody'
          group: 'nobody'
          permissions: '644'
          enabled: 'true'
          download_url: 'http://susestudio.com/api/v1/user/files/21/data'
        }
        {
          id: '22'
          filename: 'appliances.xml'
          path: '/'
          owner: 'nobody'
          group: 'nobody'
          permissions: '644'
          enabled: 'true'
          download_url: 'http://susestudio.com/api/v1/user/files/22/data'
        }
      ]

