assert = require 'assert'

session = (creds, apimpl = null) ->
  mode = p for p in ['user', 'admin'] when p of creds
  assert mode in ['user', 'admin']
  , "did you want an admin session or a user session? (got #{mode})"
  sess = creds[mode]
  assert sess.url, "missing session: url"
  common = require '../lo/common'
  lo = require "../lo/#{mode}"
  fe = (require "./#{mode}").frontend
  unless apimpl?
    apimpl = lo.api common.rpc options: sess
  new fe apimpl

exports.session = session
