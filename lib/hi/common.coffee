assert = require 'assert'

session = (creds) ->
  mode = p for p in ['user', 'admin'] when p of creds
  assert mode, 'did you want an admin session or a user session?'
  sess = creds[mode]
  assert sess.url, "missing session: url"
  if mode is 'admin'
    new Admin creds
  else
    new User creds

Admin = (anapi) ->
  @about = (done) ->
    anapi GET '/about', done
  @active_users = (done) ->
    anapi GET '/active_users', done
  @job_history = (done) ->
    anapi GET '/job_history', done
  @running_jobs = (done) ->
    anapi GET '/running_jobs', done
  @summary = (done) ->
    anapi GET '/summary', done
  @health_check = (done) ->
    anapi GET '/health_check', done
  @

User = (creds) ->
  @

exports.session = session
exports.Admin = Admin
exports.User = User
