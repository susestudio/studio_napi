_request = require('http').request

exports.request = (options, done) ->
  req = _request options, (res) ->
    done undefined, res
  req.end()

