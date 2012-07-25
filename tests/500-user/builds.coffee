tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'lists finished builds for an appliance', (done) ->
    unapi GET '/builds', {appliance_id: 42}, async done, (err, r) ->
      no_error err
      contains r, builds: [
        {
          id: '28'
          version: '0.0.1'
          state: 'finished'
          expired: 'false'
          image_type: 'oem'
          checksum:
            md5: 'bf1a0f08884ebac13f30b0fc62dfc44a'
            sha1: 'bf988e8a338bd4996be33c840de804126fecfeab'
          size: '238'
          compressed_image_size: '87'
          download_url: 'http://susestudio.com/download/bf1a0f08884ebac13f30b0fc62dfc44a/Cornelius_JeOS.x86_64-0.0.1.oem.tar.gz'
        }
      ]

