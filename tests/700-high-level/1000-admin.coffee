tools = require '../tools'
studio = require '../../lib/hi/common'

describe 'High-level Admin API:', ->

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
        done()

