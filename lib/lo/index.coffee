assert = require 'assert'

session = (creds, rpcimpl = null) ->
  mode = p for p in ['user', 'admin'] when p of creds
  assert mode in ['user', 'admin']
  , "did you want an admin session or a user session? (got #{mode})"
  sess = creds[mode]
  assert sess.url, "missing session: url"
  unless rpcimpl?
    common = require '../lo/common'
    rpcimpl = common.rpc
  lo = require "./#{mode}"
  lo.api rpcimpl options: sess

exports.session = session
