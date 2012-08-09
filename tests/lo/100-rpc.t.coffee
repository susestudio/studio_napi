expect = (require 'chai').expect
rpc = (require './lib-lo-common').rpc
tools = require '../tools'

describe 'RPC (HTTP) client', ->

  it 'calls http.request with correctly transformed arguments', (done) ->
    httprequest = (reqopts, done) -> done undefined, reqopts

    anrpc = rpc httprequest, options:
      url: 'http://example.org:4269/here/there'
      user: 'ytsarev'
      key: 'blabla'

    anrpc 'DELETE', '/fubar', foo: 'bar', (err, res) ->
      no_error err
      expected =
        method: 'DELETE'
        path: '/here/there/fubar'
        port: '4269'
        hostname: 'example.org'
        auth: 'ytsarev:blabla'
      contains res, expected
      done()

  it 'embeds API params in the requested url', (done) ->
    httprequest = (reqopts, done) -> done undefined, reqopts

    anrpc = rpc httprequest, options:
      url: 'http://example.org:6942/here/there'
      user: 'ytsarev'
      key: 'blabla'

    anrpc 'PUT', '/snafu/:foo/omg/:wtf', foo: 'bar', wtf: 'rofl', (err, res) ->
      no_error err
      expected =
        method: 'PUT'
        path: '/here/there/snafu/bar/omg/rofl'
        port: '6942'
        hostname: 'example.org'
        auth: 'ytsarev:blabla'
      contains res, expected
      done()

