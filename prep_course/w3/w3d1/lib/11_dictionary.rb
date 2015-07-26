class Dictionary

  attr_accessor :entries

  def initialize
    self.entries = {}
  end

  def add(entry)
    entry = {entry => nil} if entry.class == String
    entries.merge! entry
  end

  def keywords
    entries.keys.sort
  end

  def include?(entry)
    entries.has_key? entry
  end

  def find(entry)
    entries.select{ |word, definition| word.start_with? entry }
  end

  def printable
    to_print = ""
    entries.sort.each do |entry, definition|
      to_print << "[#{entry}] \"#{definition}\"\n"
    end
    to_print.chomp
  end
  
end