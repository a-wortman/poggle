require '../poggler_parser'
require '../parser_parts/matcher'

grammar = File.open("./file_parse/bit_twiddling/grammar", "r").read
parser = PogglerParser.parse!(grammar)

data = File.open("./file_parse/bit_twiddling/file", "r").read
parser.match(Matcher.new(data))
