class Array

  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end

    self
  end

  def my_map(&prc)
    new_arr = []
    self.my_each do |i|
      new_arr << prc.call(i)
    end

    new_arr
  end

  def my_select(&prc)
    new_arr = []

    self.my_each do |i|
      new_arr << i if prc.call(i)
    end

    new_arr
  end

  def my_inject(&prc)
    output = self[0]

    self.drop(1).my_each do |i|
      output = prc.call(output, i)
    end

    output
  end

  def my_sort!(&prc)
    changed = true
    while changed
      changed = false
      self[0..-2].each_with_index do |num, idx|
        if prc.call(num, self[idx + 1]) > 0
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          changed = true
        end
      end
    end
    
    self
  end

  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end

  def eval_block(*args, &prc)
    if block_given?
      prc.call(*args)
    else
      puts "NO BLOCK GIVEN"
    end
  end

if __FILE__ == $PROGRAM_NAME
  eval_block("Kerry", "Washington", 23) do |fname, lname, score|
    puts "#{lname}, #{fname} won #{score} votes."
  end ## => should print Washington, Kerry won 23 votes, and return nil

  p eval_block(1,2,3,4,5) { |*args| args.inject(:+)}  == 15

  p eval_block(1, 2, 3) == nil ## => should print no block given, return nil
end