#! /bin/sh
rtlr poggler.rtlr -o poggler_parser.rb -f
REPLACEALL="Dir[File.join(File.dirname(__FILE__), 'parser_parts', '**', '*.rb')].each {|file| require file }"
sed -i "s/^.*REPLACEME.$/$REPLACEALL/" poggler_parser.rb
