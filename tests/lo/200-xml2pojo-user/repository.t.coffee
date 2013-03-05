{parse, transform} = require './setup'

describe 'XML -> POJO xforms, user: GET /repositories/:repo', ->

  it 'gives info for a repository', (done) ->
    parse 'tests/user/GET_repository.xml', async done, (err, r) ->
      no_error err
      r = transform 'GET /repositories/:repo', r
      contains r, repository:
        id: '7'
        name: 'Moblin Base'
        type: 'rpm-md'
        base_system: '11.1'
        base_url: 'http://download.opensuse.org/repositories/Moblin:/Base/openSUSE_11.1'

