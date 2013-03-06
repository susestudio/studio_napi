assert = require 'assert'

appliance = require './app'

frontend = (unapi) ->
  @appliances = (done) ->
    unapi GET '/appliances', done
  @create = (data) ->
    assert 'appliance' of data
    new appliance.frontend data.appliance, unapi
  @delete = (data, done) ->
    assert 'appliance' of data
    unapi DELETE "/appliances/:app", {app: data.appliance}, done
  @packages = (done) ->
    unapi GET '/rpms', done
  @

exports.frontend = frontend
