class Lexer
  KEYWORDS = %w(class def false if nil true while)

  def tokenize(code = nil)
    return nil if code.nil?
    initialize_instance_variables(code)
    scan
    @tokens
  end

  private
  def scan
    while @position < @code.size
      @chunk = @code[@position..-1]
      sweep_and_call(
          [:recognize_identifier,  :recognize_constant, :recognize_number,   :recognize_string,
           :recognize_indentation, :recognize_operator, :ignore_whitespaces, :recognize_single_char]
      )
    end
    close_all_open_blocks
  end

  def initialize_instance_variables(code)
    @code = code.chomp
    @position = 0
    @current_indent = 0
    @tokens = []
    @indent_stack = []
  end

  def sweep_and_call(methods)
    methods.each { |method|
      break if send method
    }
  end

  def recognize_identifier
    identifier = @chunk[/\A([a-z]\w*)/, 1]
    if identifier
      if is_keyword?(identifier)
        @tokens << [identifier.upcase.to_sym, identifier]
      else
        @tokens << [:IDENTIFIER, identifier]
      end
      @position += identifier.size
    end
    not identifier.nil?
  end

  def is_keyword?(identifier)
    KEYWORDS.include?(identifier)
  end

  def recognize_constant
    constant = @chunk[/\A([A-Z]\w*)/, 1]
    if constant
      @tokens << [:CONSTANT, constant]
      @position += constant.size
    end
    not constant.nil?
  end

  def recognize_number
    number = @chunk[/\A([0-9]+)/, 1]
    if number
      @tokens << [:NUMBER, number.to_i]
      @position += number.size
    end
    not number.nil?
  end

  def recognize_string
    string = @chunk[/\A"(.*?)"/, 1]
    if string
      @tokens << [:STRING, string]
      @position += string.size + 2
    end
    not string.nil?
  end

  def recognize_indentation
    indent = @chunk[/\A:\n( +)/m, 1]
    if indent
      if is_bad_indent?(indent)
        raise "Bad indent level, got #{indent.size} indents, expected > #{@current_indent}"
      end
      @current_indent = indent.size
      @indent_stack.push(@current_indent)
      @tokens << [:INDENT, indent.size]
      @position += indent.size + 2
    else
      indent = @chunk[/\A\n( *)/m, 1]
      if indent
        if indent.size == @current_indent
          @tokens << [:NEWLINE, "\n"]
        elsif indent.size < @current_indent
          while indent.size < @current_indent
            @indent_stack.pop
            @current_indent = @indent_stack.first || 0
            @tokens << [:DEDENT, indent.size]
          end
          @tokens << [:NEWLINE, "\n"]
        else
          raise "Missing ':'"
        end
        @position += indent.size + 1
      end
    end
    not indent.nil?
  end

  def is_bad_indent?(indent)
    indent.size <= @current_indent
  end

  def recognize_operator
    operator = @chunk[/\A(\|\||&&|==|!=|<=|>=|>|<|\+|\-)/, 1]
    if operator
      @tokens << [operator, operator]
      @position += operator.size
    end
    not operator.nil?
  end

  def recognize_single_char
    value = @chunk[0]
    @tokens << [value, value]
    @position += 1
  end

  def close_all_open_blocks
    until @indent_stack.empty?
      @indent_stack.pop
      @tokens << [:DEDENT, @indent_stack.first || 0]
    end
  end

  def ignore_whitespaces
    whitespace = @chunk.match(/\A /)
    if whitespace
      @position += 1
    end
    not whitespace.nil?
  end

end