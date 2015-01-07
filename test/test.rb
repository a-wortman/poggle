#! /usr/bin/env ruby

require '../poggler_parser'
require '../parser_parts/matcher'

dirs = Dir.glob("**/*")
dirs.delete("test.rb")
dirs = dirs.select { |name| File.file? name }

expect_good = dirs.select { |name| name =~ /\/good\// }
expect_bad = dirs.select { |name| name =~ /\/bad\// }

puts "Expecting the following to be good:", expect_good
puts "Expecting the following to be bad:", expect_bad

def test_good(filenames)
  filenames.each { |name|
    puts "Testing #{name}..."
    contents = File.open(name, "r").read
    parser = PogglerParser.parse!(contents)
    data = File.open("#{name}.file", "r").read
    parser.match(Matcher.new data)
    puts "  [x] Passed"
  }
end

def test_bad(filenames)
  puts "Not testing for badness."
end

test_good expect_good


