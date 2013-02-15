require './tools'

describe 'tools#contains', ->

  it 'requires `expected` to be Object', ->
    (expect -> contains {foo: 42}, 42).to.throw Error

  it 'requires `actual` to be Object', ->
    (expect -> contains 42, {foo: 42}).to.throw Error

  it 'requires arguments to have same keys', ->
    (expect -> contains {FOO: 42}, {foo: 42}).to.throw Error

  it 'requires same keys to have same values', ->
    (expect -> contains {foo: 42}, {foo: 69}).to.throw Error

  it 'succeeds with exact matches', ->
    contains {foo: 42}, {foo: 42}

  it 'succeeds with `expected` a subset of `actual`', ->
    contains {foo: 42, bar: 69}, {foo: 42}

  it 'does not mix up keys or values', ->
    (expect -> contains {foo: 69, bar: 42}, {foo: 42, bar: 69})
      .to.throw Error

  it 'works with arrays', ->
    contains [10, 20], [10, 20]
    contains [10, 20, 30], [10, 20]

  it 'works with objects containing arrays', ->
    contains {foo: [10, 20]}, {foo: [10, 20]}
    contains {foo: [10, 20, 30]}, {foo: [10, 20]}

  it 'rejects nesting mismatches', ->
    (expect -> contains {foo: [[10, 20]]}, {foo: [10, 20]})
      .to.throw Error
