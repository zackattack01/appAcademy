require_relative 'keypad'
require 'byebug'


class KeypadTester

  def initialize(code_length, mode_keys)
    @mode_keys = mode_keys
    @keypad = Keypad.new(code_length, mode_keys)
    @keys_pressed = 0
    @codes = (0..9).to_a.repeated_permutation(code_length).to_a
  end

  def run
    catch :all_found do
      codes.each_with_index do |keyset, idx|
        keyset << mode_keys.sample unless idx < codes.length - 1         &&
                                   mode_keys.include?(codes[idx + 1][0])
        keyset.each do |key|
          keypad.press(key)
          @keys_pressed += 1
          throw :all_found if keypad.all_codes_entered?
        end
      end
      puts "All codes were not entered"
    end
    
    print_stats
  end

  def print_stats
    puts @keys_pressed
    puts keypad.duplicates
  end

  private

    attr_reader :keypad, :codes, :mode_keys
end

if __FILE__ == $PROGRAM_NAME
  test = KeypadTester.new(4, [1,2,3])
  test.run
end