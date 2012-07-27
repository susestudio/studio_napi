sinon = require 'sinon'
tools = require '../tools'
studio = require '../../lib/hi/common'

describe 'High-level Admin API:', ->

  describe 'method presence', ->

    admin =

    beforeEach () ->
      admin = studio.session admin:
        url: 'http://susestudio.com/api/admin'
        user: 'rneuhauser'
        key: 'ELaM8usq3Ryb'

    methods = '''
      about
      active_users
      job_history
      running_jobs
      summary
      health_check
    '''.split /\s+/

    for meth in methods

      do (meth) ->
        it "has #{meth}() method", (done) ->
          (expect admin, 'admin').to.have.property(meth)
            .that.is.a('function')
          done()

  describe 'argument passing', ->

    describe 'about()', ->
      it 'uses GET /about', (done) ->
        apimpl = sinon.stub().callsArg(2)

        admin = studio.session { admin:
          url: 'http://susestudio.com/api/admin'
          user: 'rneuhauser'
          key: 'ELaM8usq3Ryb'
        }
        , (a) -> apimpl a...

        admin.about (err, r) ->
          no_error err
          (expect apimpl.calledWith 'GET', '/about').to.be.true
          done()

