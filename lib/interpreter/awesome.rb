#!/usr/bin/env ruby
# The Awesome language!
#
# usage:
#
# ./awesome ../../samples/example.awm # to eval a file
#
# ./awesome
# to start the REPL
#
# on Windows run with: ruby awesome [options]
$:.unshift '.' # Fix for Ruby 1.9

require 'interpreter'
require 'readline'

interpreter = Interpreter.new
# If a file is given we eval it.
if file = ARGV.first
  interpreter.eval File.read(file)
  # Start the REPL, read-eval-print-loop, or interactive interpreter
else
  puts 'Awesome REPL, CTRL+C to quit'
  loop do
    line = Readline::readline('>> ')
    Readline::HISTORY.push(line)
    value = interpreter.eval(line)
    puts "=> #{value.ruby_value.inspect}"
  end
end