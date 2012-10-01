assert = require 'assert'

requires = (o, props) ->
  props = props.split /\s+/ if typeof props is 'string'
  assert (p of o), p for p in props

is_numeric = (s) ->
  typeof s is 'number' or typeof s is 'string' and /^\d+$/.test s

is_size = (s) ->
  s.match /^\d+[KMGTPYZ]B$/

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

  configure:
    RAM: (o) ->
      throw new TypeError unless is_size o
    disk: (o) ->
      throw new TypeError unless is_size o
    swap: (o) ->
      throw new TypeError unless is_size o

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
  configure: (o, done) ->

    try
      handlers = handlers_.configure
      for p of o
        assert (p of handlers), "unknown request #{p}"
        handlers[p] o[p]
    catch e
      if done? then return done e else throw e

    done undefined, @ if done?

  select: (foo) ->
  toggle: (foo) ->

