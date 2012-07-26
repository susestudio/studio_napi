tools = require '../tools'
studio = require '../../lib/hi/common'

describe 'High-level Admin API:', ->

  admin =

  beforeEach () ->
    admin = studio.session admin:
      url: 'http://susestudio.com/api/admin'
      user: 'rneuhauser'
      key: 'ELaM8usq3Ryb'

  it 'about()', (done) ->
    (expect admin, 'admin').to.have.property 'about'
    done()

  it 'active_users()', (done) ->
    (expect admin, 'admin').to.have.property 'active_users'
    done()

  it 'job_history()', (done) ->
    (expect admin, 'admin').to.have.property 'job_history'
    done()

  it 'running_jobs()', (done) ->
    (expect admin, 'admin').to.have.property 'running_jobs'
    done()

  it 'summary()', (done) ->
    (expect admin, 'admin').to.have.property 'summary'
    done()

  it 'health_check()', (done) ->
    (expect admin, 'admin').to.have.property 'health_check'
    done()

