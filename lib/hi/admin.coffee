frontend = (anapi) ->
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

exports.frontend = frontend
