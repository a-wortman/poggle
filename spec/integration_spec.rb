require 'spec_helper'
require 'pathname'

require 'poggle_parser'
require 'parser_parts/matcher'

dirs = Dir.glob("fixtures/metagrammars/**/*")
dirs = dirs.select { |name| File.file? name }

good_grammars = Dir.glob("spec/fixtures/metagrammars/good/*")
good_files = Dir.glob("spec/fixtures/files/good/*")
  #dirs.select { |name| name =~ /\/good\// }

describe "poggle" do
  good_grammars.each { |grammar_path|
    grammar_filename = Pathname.new(grammar_path).basename
    context "#{grammar_filename}" do
      it "parses #{grammar_filename}" do
        grammar = File.open(grammar_path, 'r').read
        expect { PoggleParser.parse!(grammar) }.to_not raise_error()
      end

      it "matches data" do
        grammar = File.open(grammar_path, 'r').read
        parser = PoggleParser.parse!(grammar)

        data_path = good_files.find { |name| name =~ /#{grammar_filename}/ }
        data = File.open(data_path, "r").read

        expect(parser.match(Matcher.new data)).to equal(true)
      end
    end
  }
end
