gem 'rspec'
require 'rspec'
require 'spec_helper'

describe Lexer do

  before :all do
    @lexer = Lexer.new
  end

  context '#new' do
    it 'should be a instance of Lexer' do
      expect(@lexer).to be_an_instance_of Lexer
    end
  end

  context '#tokenize' do
    it 'should recognize an identifier' do
      expect(@lexer.tokenize('foo')).to eq([[:IDENTIFIER, 'foo']])
    end

    it 'should recognize a CLASS keyword' do
      expect(@lexer.tokenize('class')).to eq([[:CLASS, 'class']])
    end

    it 'should recognize a DEF keyword' do
      expect(@lexer.tokenize('def')).to eq([[:DEF, 'def']])
    end

    it 'should recognize a FALSE keyword' do
      expect(@lexer.tokenize('false')).to eq([[:FALSE, 'false']])
    end

    it 'should recognize an IF keyword' do
      expect(@lexer.tokenize('if')).to eq([[:IF, 'if']])
    end

    it 'should recognize a NIL keyword' do
      expect(@lexer.tokenize('nil')).to eq([[:NIL, 'nil']])
    end

    it 'should recognize a TRUE keyword' do
      expect(@lexer.tokenize('true')).to eq([[:TRUE, 'true']])
    end

    it 'should recognize a WHILE keyword' do
      expect(@lexer.tokenize('while')).to eq([[:WHILE, 'while']])
    end

    it 'should recognize a constant (with capital letter)' do
      expect(@lexer.tokenize('MyConstant')).to eq([[:CONSTANT, 'MyConstant']])
    end

    it 'should recognize a constant (all letters upcase)' do
      expect(@lexer.tokenize('THIS_IS_MY_CONST')).to eq([[:CONSTANT, 'THIS_IS_MY_CONST']])
    end

    it 'should recognize a string' do
      expect(@lexer.tokenize('"test"')).to eq([[:STRING, 'test']])
    end

    it 'should recognize a number' do
      expect(@lexer.tokenize('123')).to eq([[:NUMBER, 123]])
    end
  end

end