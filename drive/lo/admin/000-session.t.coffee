tools = require './tools'
studio = require './lib-lo'

describe 'Low-level admin API:', ->

  creds = tools.config_file 'cfg/admin'

  it 'exposes session() function', ->
    (expect studio, 'studio').to.have.property('session')
      .that.is.a('function')

  it 'accepts `.session admin: ...`', ->
    sess = studio.session admin: creds
    (expect sess, 'session').to.be.ok

