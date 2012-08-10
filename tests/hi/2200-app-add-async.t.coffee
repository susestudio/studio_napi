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

      it 'requires property "named"', (done) ->
        app.add repository: undefined, (err) ->
          (expect err).to.be.an.instanceof(TypeError)

          app.add repository: named: 'My Repository'
          , (err) ->
            (expect err).to.not.exist

            done()

    describe '`app.add package:`', ->

      it 'accepts complete package info', (done) ->
        app.add package:
          named: 'my-package'
          from: 'A Repository'
          version: '1.2.3'
        , (err) ->
            (expect err).to.not.exist
            done()

      it 'requires all properties', (done) ->
        app.add package:
          named: 'my-package'
          from: 'A Repository'
        , (err) ->
            (expect err).to.be.instanceof(Error)
            app.add package:
              named: 'my-package'
              version: '1.2.3'
            , (err) ->
                (expect err).to.be.instanceof(Error)
                app.add package:
                  version: '1.2.3'
                  from: 'A Repository'
                , (err) ->
                    (expect err).to.be.instanceof(Error)
                    done()

    describe '`app.add pattern:`', ->

      it 'accepts complete pattern info', (done) ->
        app.add pattern:
          named: 'Checkers'
          from: 'Another Repository'
        , (err) ->
            (expect err).to.not.exist
            done()

      it 'requires all properties', (done) ->
        app.add pattern:
          named: 'Checkers'
        , (err) ->
            (expect err).to.be.instanceof(Error)
            app.add pattern:
              from: 'Another Repository'
            , (err) ->
                (expect err).to.be.instanceof(Error)
                done()

    describe '`app.add user:`', ->

      it 'accepts complete user info', (done) ->
        app.add user:
          named: 'toor'
          id: 1000
          member_of: 'wheel'
          identified_by: password: 'secret'
        , (err) ->
            (expect err).to.not.exist
            done()

      it 'requires only username', (done) ->
        app.add user:
          named: 'nighthack'
        , (err) ->
            (expect err).to.not.exist
            done()

      it 'really requires username', (done) ->
        app.add user:
          id: 1000
          member_of: 'wheel'
          identified_by: password: 'secret'
        , (err) ->
            (expect err).to.be.instanceof(Error)
            done()

      it 'wants numeric id', (done) ->
        f = (id, next) ->
          app.add user:
            named: 'snafu'
            id: id
          , next
        f 'fubar', (err) ->
          (expect err).to.be.instanceof(TypeError)
          f '1000', (err) ->
            (expect err).to.not.exist
            f 1000, (err) ->
              (expect err).to.not.exist
              done()
