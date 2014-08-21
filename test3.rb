#! /usr/bin/env ruby

require 'rubygems'
require 'rattler'

require './parser'
include Parser

class Test < Rattler::Runtime::ExtendedPackratParser
  grammar %{
    %whitespace BLANK*

    start   <- ext? components  { fulltree _ }

    components <- ~':components:' newln rule (newln+ rule)* newln
    rule <- name definition                      ~{
      puts("Read rule " + _[0]);
      _
    }

    name <- @(WORD+)
    definition <- size body / body / size

    body <- ~':=' rule_expr                      ~{
      puts("  body: " + _.join(''))
      _
    }

    rule_expr <- rule_body size_multiple?
    rule_body <- rule_cons
    rule_cons <- rule_expr ':' rule_expr / rule_opt
    rule_opt <- rule_opt '|' rule_opt / rule_atom
    rule_atom <- lit_byte / name / '(' rule_expr ')' ~{
      puts("literal byte " + _)
      _
    }

    size <- ~':' size_t                          ~{
      print("  size '" + _[0] + "'")
      if (_[1].length > 0)
         puts(" x " + _[1].join('')) rescue puts(" x " + _[1])
      else
         print("\n")
      end
      _
    }
    size_t <- ('bit' / 'byte') size_multiple?
    size_multiple <- ~'{' size_expr ~'}'
    size_expr <- size_mult
    size_mult <- size_atom '/' size_mult / size_atom '*' size_mult / size_sum
    size_sum <- size_atom '-' size_sum / size_atom '+' size_sum / size_atom
    size_atom <- size_const / size_label / '(' size_expr ')'
    size_const <- @(DIGIT+)
    size_label <- name                            { |a| a + ".size" }

    ext <- ~':ext:' ~newln exts ~newln ~newln    ~{
      puts("Expected extensions: " + _.join(', '))
      _
    }
    exts <- ~'[' ext_str (~',' ext_str)* ~']'
    ext_str <- @('"' '.' ALNUM* '"')

    lit_byte <- @('0x' XDIGIT XDIGIT)
    newln <- '\n'
  }
end

#    ext <- ':ext:' newln exts newln newln
#    exts <- ~'[' ext_str (~', ' ext_str)* ~']'
#    ext_str <- ~'"' (ALPHANUM / '.')+ ~'"'

#    %fragments
#    newln <- '\n'
#    byte <- [\x00-\x7f]
file = File.open("formats/test1", "r")
contents = file.read
Test.parse!(contents)
