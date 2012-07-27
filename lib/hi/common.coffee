assert = require 'assert'

session = (creds, apimpl = null) ->
  mode = p for p in ['user', 'admin'] when p of creds
  assert mode in ['user', 'admin']
  , "did you want an admin session or a user session? (got #{mode})"
  sess = creds[mode]
  assert sess.url, "missing session: url"
  impl = require "../lo/#{mode}"
  unless apimpl?
    apimpl = impl.api impl.rpc options: sess
  new { admin: Admin, user: User }[mode] apimpl

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
