

def shifter(word)
  word << word.shift until word[0] =~ /[aeiou]/ 
  word << word.shift if word[0] == 'u' && word[-1] == 'q'
  word.join 
end

def format(word)
  capitalized = false
  word, punct = word.rpartition(/\W+/) if word =~ /\W/
  capitalized = true if word[0] =~ /[A-Z]/
  
  word = shifter(word.downcase.split(''))

  word = word.capitalize if capitalized
  word += "ay"
  word << punct unless punct.nil?
  word
end

def translate(sentence)
  words = sentence.scan(/\S+/)
  rebuilt = []
  words.each do |word|
    word = format(word) 
    rebuilt << word
  end

  rebuilt.join(' ')
end
