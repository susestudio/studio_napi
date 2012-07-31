tools = require '../user'

unapi = tools.fileapi

describe 'User API', ->

  it 'gives info for a repository', (done) ->
    unapi GET '/repositories/:repo', {repo: 42}, async done, (err, r) ->
      no_error err
      contains r, repository:
        id: '7'
        name: 'Moblin Base'
        type: 'rpm-md'
        base_system: '11.1'
        base_url: 'http://download.opensuse.org/repositories/Moblin:/Base/openSUSE_11.1'

