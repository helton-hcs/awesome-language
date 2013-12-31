require 'rspec'
require_relative '../lib/parser/parser'

describe Parser do
  before :all do
    @parser = Parser.new
  end

  context '#new' do
    it 'should be a instance of Parser' do
      expect(@parser).to be_an_instance_of Parser
    end
  end

  context '#parse' do
    it 'should parse a number' do
      expect(@parser.parse('1')).to eq(Nodes.new([NumberNode.new(1)]))
    end

    it 'should parse an expression' do
      expect(@parser.parse(%{1\n"hi"})).to eq(Nodes.new([NumberNode.new(1), StringNode.new('hi')]))
    end

    it 'should parse a method call without arguments and without a receiver' do
      expect(@parser.parse('method')).to eq(Nodes.new([CallNode.new(nil, 'method', [])]))
    end

    it 'should parse a method call with arguments and without a receiver' do
      expect(@parser.parse('method(1, 2)')).to eq(Nodes.new([CallNode.new(nil, 'method', [NumberNode.new(1), NumberNode.new(2)])]))
    end

    it 'should parse a method call with a receiver' do
      expect(@parser.parse('1.method')).to eq(Nodes.new([CallNode.new(NumberNode.new(1), 'method', [])]))
    end

    it 'should parse a method call with arguments and with a receiver' do
      expect(@parser.parse('"test".method(1, 2)')).to eq(Nodes.new([CallNode.new(StringNode.new('test'), 'method', [NumberNode.new(1), NumberNode.new(2)])]))
    end

    it 'should parse an assignment (assign to a local variable)' do
      expect(@parser.parse('a = 1')).to eq(Nodes.new([SetLocalNode.new('a', NumberNode.new(1))]))
    end

    it 'should parse an assignment (assign to a constant)' do
      expect(@parser.parse('A = 1')).to eq(Nodes.new([SetConstantNode.new('A', NumberNode.new(1))]))
    end

    it 'should parse a def without parameters' do
      code = <<-CODE
def method:
  true
      CODE
      nodes = Nodes.new([DefNode.new('method', [], Nodes.new([TrueNode.new]))])
      expect(@parser.parse(code)).to eq(nodes)
    end

    it 'should parse a def with parameters' do
      code = <<-CODE
def method(a, b):
  true
      CODE
      nodes = Nodes.new([DefNode.new('method', %w(a b), Nodes.new([TrueNode.new]))])
      expect(@parser.parse(code)).to eq(nodes)
    end

    it 'should parse a class definition' do
      code = <<-CODE
class Muffin:
  true
      CODE
      nodes = Nodes.new([ClassNode.new('Muffin', Nodes.new([TrueNode.new]))])
      expect(@parser.parse(code)).to eq(nodes)
    end

    it 'should parse an arithmetic expression (obeying the operator precedence)' do
      nodes = Nodes.new([CallNode.new(NumberNode.new(1), '+', [CallNode.new(NumberNode.new(2), '*', [NumberNode.new(3)])])])
      expect(@parser.parse('1 + 2 * 3')).to eq(nodes)
      expect(@parser.parse('1 + (2 * 3)')).to eq(nodes)
    end

    it 'should parse a binary operator' do
      expect(@parser.parse('1 + 2 || 3')).to eql(Nodes.new([CallNode.new(CallNode.new(NumberNode.new(1), '+', [NumberNode.new(2)]), '||', [NumberNode.new(3)])]))
    end

    it 'should parse a unary operator' do
      expect(@parser.parse('!2')).to eq(Nodes.new([CallNode.new(NumberNode.new(2), '!', [])]))
    end

    it 'should parse a if statement' do
      code = <<-CODE
if true:
  nil
      CODE
      nodes = Nodes.new([IfNode.new(TrueNode.new,
                                    Nodes.new([NilNode.new]))])
      expect(@parser.parse(code)).to eq(nodes)
    end

    it 'should parse a while statement' do
      code = <<-CODE
while true:
  print("test")
      CODE
      nodes = Nodes.new([WhileNode.new(TrueNode.new,
                                       Nodes.new([CallNode.new(nil, 'print', [StringNode.new('test')])]))])
      expect(@parser.parse(code)).to eq(nodes)
    end
  end
end