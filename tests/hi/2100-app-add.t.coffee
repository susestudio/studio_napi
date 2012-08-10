tools = require '../tools'
studio = require './lib-hi'

describe 'High-level User API:', ->

  credentials = user:
    url: 'http://susestudio.com/api/v2/user'
    user: 'rneuhauser'
    key: 'ELaM8usq3Ryb'

  describe 'app.add', ->

    app =

    beforeEach ->
      user = studio.session credentials
      app = user.create appliance:
        named: 'Snafu!'
        based_on: 'FubarOS'

    describe '`app.add repository:`', ->

      it 'requires property "named"', ->
        f = -> app.add repository: undefined
        (expect f).to.throw()

        app.add repository:
          named: 'My Repository'

    describe '`app.add package:`', ->

      it 'accepts complete package info', ->
        app.add package:
          named: 'my-package'
          from: 'A Repository'
          version: '1.2.3'

      it 'requires all properties', ->
        f = -> app.add package:
          named: 'my-package'
          from: 'A Repository'
        (expect f).to.throw()
        f = -> app.add package:
          named: 'my-package'
          version: '1.2.3'
        (expect f).to.throw()

    describe '`app.add pattern:`', ->

      it 'accepts complete pattern info', ->
        app.add pattern:
          named: 'Checkers'
          from: 'Another Repository'

      it 'requires all properties', ->
        f = -> app.add pattern:
          named: 'Checkers'
        (expect f).to.throw()
        f = -> app.add pattern:
          from: 'Another Repository'
        (expect f).to.throw()

    describe '`app.add user:`', ->

      it 'accepts complete user info', ->
        app.add user:
          named: 'toor'
          id: 1000
          member_of: 'wheel'
          identified_by: password: 'secret'

      it 'requires only username', ->
        app.add user:
          named: 'nighthack'

      it 'really requires username', ->
        f = -> app.add user:
          id: 1000
          member_of: 'wheel'
          identified_by: password: 'secret'
        (expect f).to.throw()

      it 'wants numeric id', ->
        f = (id) -> () ->
          app.add user:
            named: 'snafu'
            id: id
        (expect f 'fubar').to.throw(TypeError)
        (expect f '1000').to.not.throw()
        (expect f 1000).to.not.throw()
