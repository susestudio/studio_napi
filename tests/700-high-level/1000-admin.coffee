tools = require '../tools'
studio = require '../../lib/hi/common'

describe 'High-level Admin API:', ->

  create_admin = ->
    studio.session admin:
      url: 'http://susestudio.com/api/admin'
      user: 'rneuhauser'
      key: 'ELaM8usq3Ryb'

  it 'about()', (done) ->

    admin = create_admin()
    (expect admin, 'admin').to.have.property 'about'

    done()

  it 'active_users()', (done) ->

    admin = create_admin()
    (expect admin, 'admin').to.have.property 'active_users'

    done()

  it 'job_history()', (done) ->

    admin = create_admin()
    (expect admin, 'admin').to.have.property 'job_history'

    done()

  it 'running_jobs()', (done) ->

    admin = create_admin()
    (expect admin, 'admin').to.have.property 'running_jobs'

    done()

  it 'summary()', (done) ->

    admin = create_admin()
    (expect admin, 'admin').to.have.property 'summary'

    done()

  it 'health_check()', (done) ->

    admin = create_admin()
    (expect admin, 'admin').to.have.property 'health_check'

    done()

