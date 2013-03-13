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

  methods =
    'DELETE /fubar': yes
    'PUT /snafu/:foo/omg/:wtf': yes
    'GET /snafu/:foo': yes
    'GET /snafu/:a': yes

  options =
    url: 'http://example.org:6942/here/there'
    user: 'ytsarev'
    key: 'blabla'

  beforeEach ->
    anrpc = (rpc httprequest, options: options) methods

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

  it 'puts extraneous API params in the query string', (done) ->

    anrpc 'GET', '/snafu/:foo', foo: 'bar', a: 'b', c: 'd', (err, res) ->
      no_error err
      contains res, opts \
        method: 'GET'
      , path: '/here/there/snafu/bar?a=b&c=d'
      done()

  it 'complains about :words in `path` w/o entries in `args`', (done) ->

    anrpc 'GET', '/snafu/:foo', bar: 'qux', (err, res) ->
      (expect err, 'error').to.be.an.instanceof Error
      (expect err, 'error').to.have.property 'message'
      , "GET /snafu/:foo: parameter 'foo' not found in arguments"
      done()

  it 'generates *almost* RFC2396-compliant paths and query strings', (done) ->

    # see rant in lib/lo/url.coffee

    s = "-_.~!'()*%:/?#[]@$&+,;="
    r = "-_.~!'()*%25%3A%2F%3F%23%5B%5D%40%24%26%2B%2C%3B%3D"
    anrpc 'GET', '/snafu/:a', a: s, b: s, (err, res) ->
      no_error err
      contains res, opts \
        method: 'GET'
      , path: "/here/there/snafu/#{r}?b=#{r}"
      done()

