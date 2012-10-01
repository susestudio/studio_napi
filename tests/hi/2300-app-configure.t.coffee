tools = require '../tools'
studio = require './lib-hi'

describe 'High-level User API:', ->

  credentials = user:
    url: 'http://susestudio.com/api/v2/user'
    user: 'rneuhauser'
    key: 'ELaM8usq3Ryb'

  describe 'app.configure', ->

    app =

    beforeEach ->
      user = studio.session credentials
      app = user.create appliance:
        named: 'Snafu!'
        based_on: 'FubarOS'

    describe '`app.configure RAM:`', ->

      it 'requires human-readable size value', ->
        f = (size) -> -> app.configure RAM: size
        (expect f '16').to.throw TypeError
        (expect f 16).to.throw TypeError
        (expect f '16GB').to.not.throw()

    describe '`app.configure disk:`', ->

      it 'requires human-readable size value', ->
        f = (size) -> -> app.configure disk: size
        (expect f '42').to.throw TypeError
        (expect f 42).to.throw TypeError
        (expect f '42TB').to.not.throw()

    describe '`app.configure swap:`', ->

      it 'requires human-readable size value', ->
        f = (size) -> -> app.configure swap: size
        (expect f '7').to.throw TypeError
        (expect f 7).to.throw TypeError
        (expect f '7GB').to.not.throw()
