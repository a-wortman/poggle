#! /bin/sh
rtlr poggle.rtlr -o poggle_parser.rb -f
REPLACEALL="Dir[File.join(File.dirname(__FILE__), 'parser_parts', '**', '*.rb')].each {|file| require file }"
sed -i "s/^.*REPLACEME.$/$REPLACEALL/" poggle_parser.rb
