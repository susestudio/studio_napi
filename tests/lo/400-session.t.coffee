tools = require '../tools'
studio = require './lib-lo'

describe 'Low-level User API:', ->

  it 'exposes session() function', ->
    (expect studio, 'studio').to.have.property('session')
      .that.is.a('function')

  it 'accepts `.session admin: ...`', ->
    session = studio.session admin:
      url: 'http://susestudio.com/api/v2/admin'
      user: 'rneuhauser'
      key: 'ELaM8usq3Ryb'
    (expect session, 'session').to.be.ok

  it 'accepts `.session user: ...`', ->
    session = studio.session user:
      url: 'http://susestudio.com/api/v2/user'
      user: 'rneuhauser'
      key: 'ELaM8usq3Ryb'
    (expect session, 'session').to.be.ok

