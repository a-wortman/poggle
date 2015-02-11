#! /usr/bin/env ruby

require './poggle_parser'
require './parser_parts/matcher'

metagrammar = ARGV[0] or raise "Provide the name of a grammar in 'formats/'"
dataFile = ARGV[1] or raise "Provide the relative path of a file from here to parse"

grammarContents = File.open("formats/#{metagrammar}", "r").read
parser = PoggleParser.parse!(grammarContents)

data = File.open(dataFile, "r").read
matched = parser.match(Matcher.new data)
if matched
  puts "[+] Matched!"
else
  puts "[-] No match."
end
