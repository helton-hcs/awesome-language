require 'rspec'
require_relative '../lib/interpreter/interpreter'
require_relative 'spec_helper'

describe Interpreter do

  context '#eval' do
    it 'should eval a number' do
      expect(Interpreter.new.eval('1').ruby_value).to eq(1)
    end

    it 'should eval a true' do
      expect(Interpreter.new.eval('true').ruby_value).to eq(true)
    end

    it 'should eval a false' do
      expect(Interpreter.new.eval('false').ruby_value).to eq(false)
    end

    it 'should eval a nil' do
      expect(Interpreter.new.eval('nil').ruby_value).to be_nil
    end

    it 'should eval a assign' do
      expect(Interpreter.new.eval('a = 2; 3; a').ruby_value).to eq(2)
    end

    it 'should eval a method' do
      pending('fixing...be patient :)')
      code = <<-CODE
def boo(a):
  a

boo("yah!")
      CODE
      expect(Interpreter.new.eval(code).ruby_value).to eq('yah!')
    end

    it 'should eval a reopened class' do
      pending('fixing...be patient :)')
      code = <<-CODE
class Number:
  def ten:
    10

1.ten
      CODE
      expect(Interpreter.new.eval(code).ruby_value).to eq(10)
    end

    it 'should eval a class definition' do
      pending('fixing...be patient :)')
      code = <<-CODE
class Pony:
  def awesome:
    true

Pony.new.awesome
      CODE
      expect(Interpreter.new.eval(code).ruby_value).to eq(true)
    end

    it 'should eval a if' do
      code = <<-CODE
if true:
  "works!"
      CODE
      expect(Interpreter.new.eval(code).ruby_value).to eq('works!')
    end

    it 'should eval a small code' do
      pending('fixing...be patient :)')
      code = <<-CODE
class Awesome:
  def does_it_work:
    "yeah!"

awesome_object = Awesome.new
if awesome_object:
  print(awesome_object.does_it_work)
      CODE
      output = capture_stdout { Interpreter.new.eval(code) }.chomp
      expect(output).to eq('yeah!')
    end
  end
end