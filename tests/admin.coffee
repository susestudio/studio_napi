tools = require './tools'

exports.api2file = api2file =
  'GET /about': 'about'
  'GET /active_users': 'active_users'
  'GET /health_check': 'health_check'
  'GET /job_history': 'job_history'
  'GET /running_jobs': 'running_jobs'
  'GET /summary': 'summary'

