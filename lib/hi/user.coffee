assert = require 'assert'

appliance = require './app'

frontend = (unapi) ->
  @create = (data) ->
    assert 'appliance' of data
    new appliance.frontend data.appliance, unapi
  @

exports.frontend = frontend
