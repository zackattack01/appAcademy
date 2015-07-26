INT_TO_WORD = { 0 => '', 1 => 'one', 2 => 'two', 3 => 'three', 
    4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven',8 => 'eight', 
    9 => 'nine',10 => 'ten', 11 => 'eleven', 12 => 'twelve', 
    13 => 'thirteen', 14 => 'fourteen',15 => 'fifteen', 16 => 'sixteen',
    17 => 'seventeen',18 => 'eighteen',19 => 'nineteen',20 => 'twenty',
    30 => 'thirty',40 => 'forty',50 => 'fifty',60 => 'sixty',70 => 'seventy',
    80 => 'eighty', 90 => 'ninety' }
class Fixnum
                                        
  def recursive_words(int)
    
    strint = int.to_s
    if int < 21 || (int < 100 && int % 10 == 0)
      return INT_TO_WORD[int.to_i]
    elsif int < 100
      "#{INT_TO_WORD[strint[0].to_i * 10]} #{recursive_words(strint[1].to_i)}"
    elsif int < 1000
      if strint[1..-1] == "00"
        "#{INT_TO_WORD[strint[0].to_i]} hundred"
      else 
        "#{INT_TO_WORD[strint[0].to_i]} hundred " +
        "#{recursive_words(strint[1..-1].to_i)}"
      end
    end
  end

  def in_words
    solution = []
    return 'zero' if self == 0
    mults = ["","thousand", "million", "billion", "trillion"]
    strself = self.to_s
    strself.prepend('0') until strself.length % 3 == 0
    strself.split('').each_slice(3).to_a.map{|x| x.join.to_i }.each do |chunk|
      solution << recursive_words(chunk)
    end
    solution.reverse.map.with_index do |chunk, idx| 
      chunk == "" ? "" : "#{chunk} #{mults[idx]} " 
    end.reverse.join.strip  
  end

end