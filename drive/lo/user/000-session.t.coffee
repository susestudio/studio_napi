tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'

  it 'exposes session() function', ->
    (expect studio, 'studio').to.have.property('session')
      .that.is.a('function')

  it 'accepts `.session user: ...`', ->
    sess = studio.session user: creds
    (expect sess, 'session').to.be.ok

