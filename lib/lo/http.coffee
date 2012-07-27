request = require('http').request

exports.napi_req = (options) ->
  console.log options
  req = request options, (res) ->
    res.on 'data', (chunk) ->
      console.log chunk.toString()
  req.end()

