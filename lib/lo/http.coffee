request = require('http').request

exports.napi_req = (options, done) ->
  req = request options, (res) ->
    body = ''
    res.on 'data', (chunk) ->
      c = chunk.toString()
      body += c
    res.on 'end', ->
      done undefined, body
  req.end()

