class Array
  def my_uniq
    uniq_arr = []
    self.each { |el| uniq_arr << el if uniq_arr.count(el) < 1 }

    uniq_arr
  end

  def two_sum
    pairs = []

    (0...self.length-1).each do |x|
      (1...self.length-x).each do |y|
        pairs << [x, y+x] if self[x] + self[y+x] == 0
      end
    end

    pairs
  end

  def median
    mid = self.length/2
    self.length.odd? ? self[mid] : (self[mid] + self[mid-1])/2.0
  end

  def my_transpose()
    transposed = Array.new(3) { [] }

    self.each.with_index do |row, row_i|
      row.each.with_index do |col, col_i|
        transposed[col_i] << col
      end
    end

    transposed
  end
end

class String
  def caesar(shift)
    shifted = ('a'..'z').to_a.rotate(shift)
    straight = ('a'..'z').to_a

    encoded = ""

    self.each_char.with_index do |character|
      encoded += shifted[ straight.index(character) ]
    end

    encoded
  end
end

class Hash
  def difference(other_hash)
    a = self
    b = other_hash
    keep_keys = (a.keys | b.keys) - (a.keys & b.keys)
    self.merge(other_hash).select { |k, v| keep_keys.include?(k) }
  end
end

class Fixnum
  def stringify(base)
    str = []
    str_map = {}
    ("0".."9").to_a.each_with_index do |num, idx|
     str_map[idx] = num
    end
    ("A".."F").to_a.each_with_index do |char, idx|
     str_map[idx + 10] = char
    end

    i = 0
    while (self / base**i) != 0
      str.unshift((self / base**i) % base)
      i += 1
    end

    str.map { |num| str_map[num] }.join
  end
end
