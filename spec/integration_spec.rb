require 'spec_helper'
require 'pathname'

require 'poggle_parser'
require 'parser_parts/matcher'

good_grammars = Dir.glob("spec/fixtures/metagrammars/good/*")
good_files = Dir.glob("spec/fixtures/files/good/*")

bad_grammars = Dir.glob("spec/fixtures/metagrammars/bad/*")

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

  context "rule_double_variables" do
    it "rejects double variable declarations" do
      grammar = File.open("spec/fixtures/metagrammars/bad/rule_double_variables", 'r').read
      expect { PoggleParser.parse!(grammar) }.to raise_error("Cannot rebind variable 'a'")
    end
  end
end
