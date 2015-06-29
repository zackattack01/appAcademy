require 'set'

def substrings(str)
	l, subs = str.length, []
	(0...l).each{ |i| (1..(l - i)).each { |len| subs << str[i, len] } }
	subs.uniq
end

#p substrings('cat') == ["c", "ca", "cat", "a", "at", "t"] #=> true

WORDS = File.read('dictionary.txt').chomp.split(/\n/)
def subwords(str)
	subs = substrings(str)
	subs.select{ |word| WORDS.include? word }
end

start = Time.now
500.times{ subwords('abashment') }
puts "array: #{Time.now - start}" #=> array: 54.659007165

$VERBOSE = nil
WORDS = WORDS.to_set
start = Time.now
500.times{ subwords('abashment') }
puts "set: #{Time.now - start}" #=> set: 0.032638375 woah


#=> ["a", "abash", "abashment", "bash", "as", "ash", "sh", "me", "men", "en"]