tools = require './tools'
studio = require './lib-lo'

describe 'Low-level user API:', ->

  creds = tools.config_file 'cfg/user'

  responds_to 'GET /appliances/:app/status', (done) ->
    sess = studio.session user: creds
    sess GET '/appliances/:app/status', { app: 0 }, (err, r) ->
      (expect err, 'error').to.have.property 'code', 'invalid_appliance_id'
      (expect err, 'error').to.have.property 'message'
      do done

      return

      # FIXME successful roundtrip from appliance creation
      # FIXME to GET /appliances/:app/status is too involved for now

      no_error err
      (expect r, 'status').to.have.keys 'status'
      r = r.status
      (expect r, 'status').to.have.keys 'state', 'issues'

      (expect r.issues, 'issues').to.be.an 'array'
      for i in r.issues
        (expect i, 'issue').to.have.keys 'text', 'type'
      do done
