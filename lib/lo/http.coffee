_request = require('http').request

exports.request = (options, done) ->
  req = _request options, (res) ->
    body = ''
    res.on 'data', (chunk) ->
      c = chunk.toString()
      body += c
    res.on 'end', ->
      done undefined, body
  req.end()

