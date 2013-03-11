expect = (require 'chai').expect
sinon = require 'sinon'
tools = require '../tools'

common = require './lib-lo-common'

methods =
  'GET /fubar':
    root: 'snafu'
    output: common.asis
  'GET /xml-syntax-error':
    root: 'whatever'
    output: 'this is not xml'

fakeHTTPresponse =
  headers:
    'content-type': 'application/xml'
  on: (evt, handler) ->
    do handler if evt is 'end'

describe 'common.api', ->

  it 'fails early for unknown endpoints', ->
    myrpc = sinon.mock().never()
    mycb = sinon.mock().once().withExactArgs \
      new Error 'GET /snafu: unknown method'

    napi = (common.api methods) myrpc
    napi GET '/snafu', omg: 'wtf', mycb

    mycb.verify()
    myrpc.verify()

  it 'uses the rpc function', ->
    myrpc = sinon.mock().once().withArgs \
      'GET'
    , '/fubar'
    , omg: 'wtf'

    napi = (common.api methods) myrpc
    napi GET '/fubar', omg: 'wtf', ->

    myrpc.verify()

  it 'rpc callback fails early on rpc errors', ->
    myrpc = sinon.mock().once().withArgs(
      'GET'
    , '/fubar'
    , omg: 'wtf'
    ).callsArgWith(3, 'rofl')
    myxml =
      parse: sinon.mock().never()
      transform: sinon.mock().once()
      verify: ->
        @parse.verify()
        @transform.verify()
    mycb = sinon.mock().once().withExactArgs 'rofl'

    napi = (common.api methods) myrpc, myxml
    napi GET '/fubar', omg: 'wtf', mycb

    myrpc.verify()
    myxml.verify()
    mycb.verify()

  it 'reports failures from xml parser', ->
    myrpc = (a, b, c..., cb) ->
      cb undefined, fakeHTTPresponse
    xml =
      parse: (_, cb) -> cb 'xml parsing error'
      transform: ->

    mycb = sinon.mock().once().withExactArgs 'xml parsing error'

    napi = (common.api methods) myrpc, xml
    napi GET '/xml-syntax-error', omg: 'wtf', mycb

    mycb.verify()

  it 'reports errors returned from server', ->
    response =
      error:
        code: 'internal_error'

    myrpc = (a, b, c..., cb) ->
      cb undefined, fakeHTTPresponse
    myxml =
      parse: (a, cb) -> cb undefined, response
      transform: ->

    mycb = sinon.mock().once().withExactArgs response.error

    napi = (common.api methods) myrpc, myxml
    napi GET '/fubar', mycb

    mycb.verify()
