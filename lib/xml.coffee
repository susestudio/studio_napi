clone = require 'clone'
xml2js = require 'xml2js'

xml2js_options = clone xml2js.defaults["0.2"]
xml2js_options.emptyTag = []
xml2js_options.explicitArray = false
xml2js_options.attrkey = "@"
xml2js_options.charkey = "#"

parser = new xml2js.Parser(xml2js_options)

exports.parse = (data, done) ->
  parser.parseString data, done
