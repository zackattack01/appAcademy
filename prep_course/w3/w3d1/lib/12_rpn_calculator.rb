class RPNCalculator
  attr_accessor :stack
  FUNC_MAP= { :* => 'times', :/ => 'divide', :+ => 'plus', :- => 'minus' }

  def initialize
  	self.stack= []
  end

  def push(num)
  	stack << num
  end

  def plus
  	check_stack
  	stack << stack.pop(2).inject(:+)
  end

  def minus
  	check_stack
  	stack << stack.pop(2).inject(:-)
  end

  def times
  	check_stack
  	stack << stack.pop(2).inject(:*)
  end

  def divide
  	check_stack
  	stack << stack.pop(2).inject(:fdiv)
  end

  def value
  	stack.last
  end

  def tokens(string)
  	string.split.map do |x|
  		if x =~ /\d+/ then x.to_f 
  	  elsif "+-*/".include?(x) then x.to_sym 
  	  else raise "Invalid token" 
  	  end
  	end
	end

	def evaluate(string)
		tokens= tokens(string)
		stack.clear
		tokens.each do |token|
			token.is_a?(Float) ? push(token) : eval("self.#{FUNC_MAP[token]}")
		end
		value
	end

  def check_stack
  	raise "calculator is empty" if stack.count < 2
  end
end
