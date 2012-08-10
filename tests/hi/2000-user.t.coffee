tools = require '../tools'
studio = require './lib-hi'

describe 'High-level User API:', ->

  credentials = user:
    url: 'http://susestudio.com/api/v2/user'
    user: 'rneuhauser'
    key: 'ELaM8usq3Ryb'

  methods = '''
    create
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
