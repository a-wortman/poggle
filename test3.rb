#! /usr/bin/env ruby

require './poggler_parser'

metagrammar = ARGV[0] || "formats/test1"

file = File.open(metagrammar, "r")
contents = file.read
PogglerParser.parse!(contents)
