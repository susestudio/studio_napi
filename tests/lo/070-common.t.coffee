require '../tools'
common = require './lib-lo-common'

describe 'HTTP verbs', ->

  verbs =
    DELETE: DELETE
    GET: GET
    POST: POST
    PUT: PUT

  for name, fun of verbs

    describe name, ->

      it 'returns arguments with its name prepended', ->
        args = ->
          'abcdefghijklmnopqrstuvwxyz'.split ''

        (expect fun).to.be.a 'function'

        r = fun do args...

        (expect r).to.be.an 'array'

        for arg, i in [name].concat do args
          (expect r[i]).to.eql arg
