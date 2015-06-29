def add(augend, addend)
  augend + addend
end

def subtract(minuend, subtrahend)
  minuend - subtrahend
end

def sum(numbers)
  return 0 if numbers.empty?
  numbers.inject(:+)
end

def multiply(numbers)
  return 0 if numbers.empty?
  numbers.inject(:*)
end

def power(number, power)
  number ** power
end

def factorial(number)
  if number < 0 || number != number.round
    return "I'm just a simple calculator :("
  end

  return 1 if number == 0
  [*1..number].inject(:*)
end