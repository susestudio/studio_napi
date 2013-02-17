expect = (require 'chai').expect
rpc = (require './lib-lo-common').rpc
tools = require '../tools'

extend = (dest, sources...) ->
  for src in sources
    for own key, val of src
      dest[key] = val
  dest

describe 'RPC (HTTP) client', ->

  httprequest = (reqopts, done) -> done undefined, reqopts
  anrpc =

  expected_opts =
    port: '6942'
    hostname: 'example.org'
    auth: 'ytsarev:blabla'

  opts = (o) -> extend {}, expected_opts, o

  beforeEach ->
    anrpc = rpc httprequest, options:
      url: 'http://example.org:6942/here/there'
      user: 'ytsarev'
      key: 'blabla'

  it 'calls http.request with correctly transformed arguments', (done) ->

    anrpc 'DELETE', '/fubar', foo: 'bar', (err, res) ->
      no_error err
      contains res, opts \
        method: 'DELETE'
      , path: '/here/there/fubar?foo=bar'
      done()

  it 'embeds API params in the requested url', (done) ->

    anrpc 'PUT', '/snafu/:foo/omg/:wtf', foo: 'bar', wtf: 'rofl', (err, res) ->
      no_error err
      contains res, opts \
        method: 'PUT'
      , path: '/here/there/snafu/bar/omg/rofl'
      done()

