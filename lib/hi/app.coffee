assert = require 'assert'

requires = (o, props) ->
  props = props.split /\s+/ if typeof props is 'string'
  assert (p of o), p for p in props

is_numeric = (s) ->
  typeof s is 'number' or typeof s is 'string' and /^\d+$/.test s

apphandlers = (acf) ->
  add:
    package: (o) ->
      requires o, 'named from version'

    pattern: (o) ->
      requires o, 'named from'

    repository: (o) ->
      requires o, 'named'
      acf.repos ?= {}
      acf.repos[o.named] = yes

    user: (o) ->
      requires o, 'named'
      if 'id' of o
        throw new TypeError unless is_numeric o.id
      if 'identified_by' of o
        assert ('password' of o.identified_by), 'identified_by.password'

exports.frontend = (cfg, apimpl) ->

  handlers_ = apphandlers cfg

  add: (o, done) ->

    try
      handlers = handlers_.add
      for p of o
        assert (p of handlers), "unknown request #{p}"
        handlers[p] o[p]
    catch e
      if done? then return done e else throw e

    done undefined, @ if done?

  commit: (err, app, done) ->
  name: cfg.named
  base_system: cfg.based_on
  configure: (foo) ->
  select: (foo) ->
  toggle: (foo) ->

