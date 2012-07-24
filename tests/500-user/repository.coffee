tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'gives all repositories for an appliance', (done) ->
    unapi GET 'repository', async done, (err, r) ->
      no_error err
      contains r, repository: {
        id: '7'
        name: 'Moblin Base'
        type: 'rpm-md'
        base_system: '11.1'
        base_url: 'http://download.opensuse.org/repositories/Moblin:/Base/openSUSE_11.1'
      }

