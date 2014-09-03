#! /usr/bin/env ruby

require './poggler_parser'
require './parser_parts/matcher'

metagrammar = ARGV[0] || "formats/test1"
dataFile = ARGV[1] || "file"

grammarFile = File.open(metagrammar, "r")
contents = grammarFile.read
parser = PogglerParser.parse!(contents)

data = File.open(dataFile, "r").read
parser.match(Matcher.new data)
