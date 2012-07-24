expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives info for a build', (done) ->
    unapi GET 'build', (err, r) ->
      no_error err
      contains r, build:
        id: '28'
        version: '0.0.1'
        state: 'finished'
        expired: 'false'
        image_type: 'oem'
        checksum:
          md5: 'f0071c5f47c892478a8d28b0fe1cfde6'
          sha1: 'bf988e8a338bd4996be33c840de804126fecfeab'
        size: '238'
        compressed_image_size: '87'
        download_url: 'http://susestudio.com/download/bf1a0f08884ebac13f30b0fc62dfc44a/Cornelius_JeOS.x86_64-0.0.1.oem.tar.gz'
      done()

