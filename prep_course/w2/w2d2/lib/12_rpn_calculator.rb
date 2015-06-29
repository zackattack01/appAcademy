class RPNCalculator
  attr_accessor :stack
  FUNC_MAP = { :+ => "plus", :- => "minus", :* => 'times', :/ => 'divide' }

  def initialize
    self.stack = []
  end
  
  def push(el)
    stack.push(el)
  end
  
  def plus
    check_size
    stack.push(stack.pop(2).inject(:+))
  end
  
  def minus
    check_size
    stack.push(stack.pop(2).inject(:-))
  end
  
  def times
    check_size
    stack.push(stack.pop(2).inject(:*))
  end
  
  def divide
    check_size
    stack.push(stack.pop(2).inject(:fdiv))
  end
  
  def value
    stack.last
  end
  
  def check_size
    raise "calculator is empty" if stack.size < 2
  end
  
  def tokens(string)
    string.split(" ").map do |char|
      "+-*/".include?(char) ? char.to_sym : char.to_i
    end
  end
  
  def evaluate(string)
    string = tokens(string)
    string.each do |el|
      if el.is_a? Symbol
        raise "Invalid token" if FUNC_MAP[el].nil?
        eval("self.#{FUNC_MAP[el]}")
      else
        stack << el
      end
    end
    stack.last
  end
end

def command_line_calculator
  @calc= RPNCalculator.new
  ARGV.empty? ? no_file_calc : file_calc
end

def file_calc
  File.readlines(ARGV[0]).each do |line|
    puts @calc.evaluate(line.chomp)
  end
end

def no_file_calc
  temp_stack = []
  temp_stack << gets.chomp until temp_stack.last == ""
  @calc.evaluate(temp_stack[0..-2].join(' '))
end
