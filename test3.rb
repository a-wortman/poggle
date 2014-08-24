#! /usr/bin/env ruby

require './poggler'

metagrammar = ARGV[0] || "formats/test1"

file = File.open(metagrammar, "r")
contents = file.read
Poggler.parse!(contents)
