#!/usr/bin/env ruby
require 'rubygems'
require 'treetop'

Treetop.load 'spectrum'

parser = SpectrumParser.new



if result = parser.parse("ctmc formula stuff = 3; global x : [0..2] init 0;
    global y : bool init false;")
  puts "Parsed Spectrum file: #{result.inspect}"
else
  puts "I say no, I don't understand."
  unless parser.terminal_failures.empty?
    puts parser.failure_reason
  else
    puts "I had a problem with line #{parser.failure_line} column #{parser.index+1}"
  end
end
