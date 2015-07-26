class Employee

  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss=nil)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee

  attr_reader :employees
  
  def initialize(name, title, salary, boss=nil, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    employees.inject(0) { |acc, el| acc += el.salary * multiplier }
  end
end
