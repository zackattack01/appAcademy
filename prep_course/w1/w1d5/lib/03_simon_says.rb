def echo(phrase)
  phrase
end

def shout(phrase)
  phrase.upcase
end

def repeat(phrase, reps = 2)
  ([phrase] * reps).join(' ')
end

def start_of_word(word, how_many_letters)
  word[0...how_many_letters]
end

def first_word(sentence)
  sentence.split(' ')[0]
end

def titleize(sentence)
  minor_words = %w{ and or nor an a but as at over by for 
    in the of on per to too }
  words = sentence.split
  words = words.map.with_index do |word, i| 
    if i == 0 then word.capitalize
    elsif minor_words.include? word then word
    else word.capitalize
    end
  end
    words.join(' ')
end
