require 'rspec'
require_relative '../lib/parser'

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
    it 'should parse a method with params' do
      code = <<-CODE
def method(a, b):
  true
      CODE
      nodes = Nodes.new([DefNode.new('method', %w(a b), Nodes.new([TrueNode.new]))])
      expect(@parser.parse(code)).to eq(nodes)
    end

    it 'should parse a WHILE statement' do
      code = <<-CODE
while true:
  print("test")
      CODE
      nodes = Nodes.new([WhileNode.new(TrueNode.new, Nodes.new([CallNode.new(nil, 'print', [StringNode.new('test')])]))])
      expect(@parser.parse(code)).to eq(nodes)
end
  end

end