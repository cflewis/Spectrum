#!/usr/bin/env ruby
require 'rubygems'
require 'treetop'

Treetop.load 'spectrum'

parser = SpectrumParser.new



if result = parser.parse(File.read("circadian.sm"))
  puts "Parsed Spectrum file: #{result.inspect}"
else
  puts "I don't understand."
  unless parser.terminal_failures.empty?
    puts parser.failure_reason
  else
    puts   "expected #{parser} to parse...\n" + 
       "failure column: #{parser.failure_column}\n" + 
       "failure index: #{parser.failure_index}\n" + 
       "failure line: #{parser.failure_line}\n" + 
       "failure reason: #{parser.failure_reason}\n"
  end
end
