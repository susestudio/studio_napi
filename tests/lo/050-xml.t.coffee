expect = (require 'chai').expect

xml = require './lib-lo-xml'

describe 'XML parser', ->

  it 'outputs empty elements as arrays', (done) ->
    doc = '''
      <laptop>
        <dead/>
      </laptop>
    '''
    xml.parse doc, (err, parsed) ->
      expect(err).to.not.be.ok
      expect(parsed)
        .to.have.deep.property('laptop.dead')
          .that.is.an('array')
          .and.is.empty
      done()

  it 'outputs singleton text nodes as property values', (done) ->
    doc = '''
      <liters>42</liters>
    '''
    xml.parse doc, (err, parsed) ->
      expect(err).to.not.be.ok
      expect(parsed)
        .to.be.an('object')
        .deep.equal(liters: '42')
      done()

  it 'outputs single children of a given element name directly', (done) ->
    doc = '''
      <volume>
        <liters>42</liters>
      </volume>
    '''
    xml.parse doc, (err, parsed) ->
      expect(err).to.not.be.ok
      expect(parsed)
        .to.be.an('object')
        .deep.equal(volume: liters: '42')
      done()

  it 'outputs multiple children with the same element name in arrays', (done) ->
    doc = '''
      <drinks>
        <beer><brand>Branik</brand></beer>
        <beer><brand>Plzen</brand></beer>
        <soda><brand>Kofola</brand></soda>
      </drinks>
    '''
    xml.parse doc, (err, parsed) ->
      expect(err).to.not.be.ok
      expect(parsed)
        .to.have.deep.property('drinks.beer')
          .that.is.an('array')
          .with.length(2)
      expect(parsed.drinks.beer[0])
        .to.be.an('object')
        .deep.equal(brand: 'Branik')
      expect(parsed.drinks.beer[1])
        .to.be.an('object')
        .deep.equal(brand: 'Plzen')
      expect(parsed)
        .to.have.deep.property('drinks.soda')
          .that.is.an('object')
          .deep.equal(brand: 'Kofola')
      done()

  it 'outputs attributes under @ property', (done) ->
    doc = '''
      <beer brand="Branik"></beer>
    '''
    xml.parse doc, (err, parsed) ->
      expect(err).to.not.be.ok
      expect(parsed)
        .to.have.deep.property('beer.@')
          .that.is.an('object')
          .with.property('brand', 'Branik')
      done()

