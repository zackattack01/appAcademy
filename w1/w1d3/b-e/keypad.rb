require 'set'
require 'byebug'

class Keypad

  attr_reader :duplicates

  def initialize(code_length, mode_keys)
    @key_history = []
    @duplicates = 0
    @code_length = code_length
    @mode_keys = mode_keys
    @possible_codes = (0..9).to_a.repeated_permutation(code_length).to_a.to_set
  end

  def press(key)
    key_history.shift if key_history.length == 5
    key_history << key

    check_code if mode_keys.include?(key_history.last)
  end

  def check_code
    return nil if key_history.length < 5

    possible_codes.delete?(key_history[0...code_length]) ||
    @duplicates += 1
  end

  def all_codes_entered?
    possible_codes.empty?
  end

  private 

    attr_reader :possible_codes, :code_length, :key_history, :mode_keys
end