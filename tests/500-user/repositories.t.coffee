{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /repositories', ->

  it 'gives all repositories for an appliance', (done) ->
    parse 'tests/user/repositories.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /repositories', r
      contains r, repositories: [
        {
          id: '7'
          name: 'Moblin Base'
          type: 'rpm-md'
          base_system: '11.1'
          base_url: 'http://download.opensuse.org/repositories/Moblin:/Base/openSUSE_11.1'
          matches: {
            repository_name: 'moblin base'
            repository_base_url: 'http://download.opensuse.org/repositories/moblin:/base/opensuse_11.1'
          }
        }
      ]

