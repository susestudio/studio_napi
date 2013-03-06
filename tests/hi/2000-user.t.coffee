sinon = require 'sinon'
tools = require '../tools'
studio = require './lib-hi'

describe 'High-level User API:', ->

  credentials = user:
    url: 'http://susestudio.com/api/v2/user'
    user: 'rneuhauser'
    key: 'ELaM8usq3Ryb'

  methods = '''
    appliances
    create
    delete
    packages
  '''.split /\s+/

  describe 'method presence', ->

    user =

    beforeEach () ->
      user = studio.session credentials

    for meth in methods

      do (meth) ->
        it "has #{meth}() method", (done) ->
          (expect user, 'user').to.have.property(meth)
            .that.is.a('function')
          done()

  describe '`user.create appliance: ...`', ->

    user =

    beforeEach ->
      user = studio.session credentials

    it 'returns an appliance frontend', ->
      (expect user, 'user').to.have.property 'create'

      app = user.create appliance:
        named: 'my system'
        based_on: 'SLES11 SP2'

      for meth in 'add configure select toggle commit'.split ' '
        (expect app, "app.#{meth}").to.have.property(meth)
          .that.is.a('function')

  describe '`user.delete appliance: ...`', ->

    user =

    it 'uses DELETE /appliances/:app', (done) ->
      cb = (e, r) ->
        no_error e
        apimpl.verify()
        done()

      apimpl = sinon.mock().once()
        .withExactArgs('DELETE', '/appliances/:app', app: 42, cb)
        .callsArg(3)

      user = studio.session credentials, (a) -> apimpl a...

      user.delete appliance: 42, cb

  describe '`user.appliances`', ->

    user =

    it 'uses GET /appliances', (done) ->
      cb = (e, r) ->
        no_error e
        apimpl.verify()
        done()

      apimpl = sinon.mock().once()
        .withExactArgs('GET', '/appliances', cb)
        .callsArg(2)

      user = studio.session credentials, (a) -> apimpl a...

      user.appliances cb

  describe '`user.packages`', ->

    it 'uses GET /rpms', (done) ->
      cb = (e, r) ->
        no_error e
        apimpl.verify()
        done()

      apimpl = sinon.mock().once()
        .withExactArgs('GET', '/rpms', cb)
        .callsArg(2)

      user = studio.session credentials, (a) -> apimpl a...

      user.packages cb

