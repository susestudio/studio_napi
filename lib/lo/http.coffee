_request = require('http').request

exports.request = (options, done) ->
  req = _request options, (res) ->
    body = new Buffer 0
    res.on 'data', (chunk) ->
      body = Buffer.concat [body, chunk]
    res.on 'end', ->
      done undefined, body
  req.end()

