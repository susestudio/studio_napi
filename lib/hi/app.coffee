assert = require 'assert'

requires = (o, props) ->
  props = props.split /\s+/ if typeof props is 'string'
  assert (p of o), p for p in props

is_numeric = (s) ->
  typeof s is 'number' or typeof s is 'string' and /^\d+$/.test s

handlers =
  add:
    package: (o) ->
      requires o, 'named from version'

    pattern: (o) ->
      requires o, 'named from'

    repository: (o) ->
      requires o, 'named'

    user: (o) ->
      requires o, 'named'
      if 'id' of o
        throw new TypeError unless is_numeric o.id
      if 'identified_by' of o
        assert ('password' of o.identified_by), 'identified_by.password'

exports.frontend = (cfg) ->

  add: (o) ->

    for p of o
      assert (p of handlers.add), "unknown request #{p}"
      handlers.add[p] o[p]

  commit: (err, app, done) ->
  name: cfg.named
  base_system: cfg.based_on
  configure: (foo) ->
  select: (foo) ->
  toggle: (foo) ->

