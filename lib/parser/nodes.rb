# Collection of nodes each one representing an expression.
class Nodes < Struct.new(:nodes)
  def <<(node)
    nodes << node
    self
  end
end

# Literals are static values that have a Ruby representation, eg.: a string, a number, 
# true, false, nil, etc.
LiteralNode = Class.new(Struct.new(:value))

NumberNode = Class.new(LiteralNode)

StringNode = Class.new(LiteralNode)

class TrueNode < LiteralNode
  def initialize
    super(true)
  end
end

class FalseNode < LiteralNode
  def initialize
    super(false)
  end
end

class NilNode < LiteralNode
  def initialize
    super(nil)
  end
end

# Node of a method call or local variable access, can take any of these forms:
# 
#   method # this form can also be a local variable
#   method(argument1, argument2)
#   receiver.method
#   receiver.method(argument1, argument2)
#
CallNode = Class.new(Struct.new(:receiver, :method, :arguments))

# Retrieving the value of a constant.
GetConstantNode = Class.new(Struct.new(:name))

# Setting the value of a constant.
SetConstantNode = Class.new(Struct.new(:name, :value))

# Setting the value of a local variable.
SetLocalNode = Class.new(Struct.new(:name, :value))

# Method definition.
DefNode = Class.new(Struct.new(:name, :params, :body))

# Class definition.
ClassNode = Class.new(Struct.new(:name, :body))

# "if" control structure. Look at this node if you want to implement other control
# structures like while, for, loop, etc.
IfNode = Class.new(Struct.new(:condition, :body))

WhileNode = Class.new(Struct.new(:condition, :body))