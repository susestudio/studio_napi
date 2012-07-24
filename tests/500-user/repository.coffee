expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API', ->

  it 'gives all repositories for an appliance', (done) ->
    unapi 'repository', (err, r) ->
      no_error err
      contains r, repository: {
        id: '7'
        name: 'Moblin Base'
        type: 'rpm-md'
        base_system: '11.1'
        base_url: 'http://download.opensuse.org/repositories/Moblin:/Base/openSUSE_11.1'
      }
      done()

