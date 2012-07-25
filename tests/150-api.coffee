expect = (require 'chai').expect
sinon = require 'sinon'
tools = require './tools'

common = require '../lib/lo/common'

methods =
  'GET /fubar':
    root: 'snafu'
    output: common.asis
  'GET /xml-syntax-error':
    root: 'whatever'
    output: 'this is not xml'

describe 'common.api', ->

  it 'fails early for unknown endpoints', ->
    myrpc = sinon.mock().never()
    mycb = sinon.mock().once().withExactArgs \
      'GET /snafu: unknown method'

    napi = (common.api methods) myrpc
    napi GET '/snafu', {omg: 'wtf'}, mycb

    mycb.verify()
    myrpc.verify()

  it 'uses the rpc function', ->
    myrpc = sinon.mock().once().withArgs \
      'GET'
    , '/fubar'
    , {omg: 'wtf'}

    napi = (common.api methods) myrpc
    napi GET '/fubar', {omg: 'wtf'}, ->

    myrpc.verify()

  it 'rpc callback fails early on rpc errors', ->
    myrpc = sinon.mock().once().withArgs(
      'GET'
    , '/fubar'
    , {omg: 'wtf'}
    ).callsArgWith(3, 'rofl')
    myxml = sinon.mock().never()
    mycb = sinon.mock().once().withExactArgs 'rofl'

    napi = (common.api methods) myrpc, myxml
    napi GET '/fubar', {omg: 'wtf'}, mycb

    myrpc.verify()
    myxml.verify()
    mycb.verify()

  it 'reports failures from xml parser', ->
    myrpc = sinon.stub()
      .callsArgWith(3, null, 'mydata')
    xml = { parse: -> }
    sinon.stub(xml, 'parse')
      .callsArgWith(1, 'xml parsing error')

    mycb = sinon.mock().once().withExactArgs 'xml parsing error'

    napi = (common.api methods) myrpc, xml
    napi GET '/xml-syntax-error', {omg: 'wtf'}, mycb

    mycb.verify()

