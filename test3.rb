#! /usr/bin/env ruby

require './poggler_parser'
require './parser_parts/matcher'

metagrammar = ARGV[0] || "formats/test1"

file = File.open(metagrammar, "r")
contents = file.read
foo = PogglerParser.parse!(contents)

data = File.open("file", "r").read
puts data.bytes[2].to_s(16)
foo.match(Matcher.new data)
