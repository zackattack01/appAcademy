class Array

  def merge_sort
    return self if length <= 1

    mid = length / 2
    left, right = self.take(mid).merge_sort, self.drop(mid).merge_sort
    merge(left, right)
  end

  def merge(left, right)
    merged = []
    until left.empty? || right.empty?
      merged << (left[0] < right[0] ? left.shift : right.shift)
    end

    merged + left + right
  end

  def subsets
    return [[]] if self.empty?

    lil_subs = self.take(length - 1).subsets
    big_subs = []
    lil_subs.each do |lil_sub|
      big_subs << lil_sub + [self.last]
    end

    lil_subs + big_subs
  end
end


def make_change(amount, coins)
  @call_count += 1
  return [] if amount == 0

  coins = coins.sort.reverse

  best_change = nil
  coins.each do |coin|
    next if coin > amount

    remaining_change = make_change(amount - coin, coins)
    change = [coin] + remaining_change
    if best_change.nil? || change.count < best_change.count
      best_change = change 
    end
  end

  best_change
end

def make_change2(amount, coins)
  @call_count += 1
  return [amount] if coins.include? amount

  coins = coins.select { |coin| coin <= amount }

  best_change = nil
  coins.each do |coin|
    change = [coin] + make_change2(amount - coin, coins)
    if best_change.nil? || change.count < best_change.count
      best_change = change
    end
  end

  best_change
end


if __FILE__ == $PROGRAM_NAME
  # puts [7, 6, 5, 4, 3, 2, 1].merge_sort == [1, 2, 3, 4, 5, 6, 7]
  # p [].subsets  == [[]]
  # p [1].subsets  == [[], [1]]
  # p [1, 2].subsets  == [[], [1], [2], [1, 2]]
  # p [1, 2, 3].subsets == [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
  @call_count = 0
  puts make_change(14, [1, 10, 7]) == [7, 7]
  p @call_count
  @call_count = 0
  puts make_change2(14, [1, 10, 7]) == [7, 7]
  p @call_count
end