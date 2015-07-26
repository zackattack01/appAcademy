require 'rspec'
require "rspec_exercises"

describe Array do

  describe "#my_uniq" do
    subject(:test_array) { [1, 2, 1, 3, 3] }

    it "returns the unique elements, in the order they first appeared" do
      expect(test_array.my_uniq).to eq([1, 2, 3])
    end
  end

  subject(:two_sum_test_arr) { [-1, 0, 2, -2, 1] }
  describe "#two_sum" do
    it "finds all pairs of positions where the elements at those positions sum to zero" do
      expect(two_sum_test_arr.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  subject(:median_arr_odd) { [1, 2, 3, 4, 5, 6, 7] }
  subject(:median_arr_even) { [1, 2, 3, 4, 5, 6, 7, 8] }
  describe "#median" do
    it "finds the median of a given array of integers" do
      expect(median_arr_odd.median).to eq(4)
      expect(median_arr_even.median).to eq(4.5)
    end
  end

  subject(:matrix) do
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
  end
  subject(:transposed_matrix) do
    [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]
  end
  describe "#my_transpose" do
    it "converts between row-oriented and column-oriented matrices" do
      expect(matrix.my_transpose).to eq(transposed_matrix)
    end
  end
end

describe String do
  subject(:zany) { "zany" }
  subject(:hello) { "hello" }
  describe "#caesar" do
    it "shifts hello by 3" do
      expect(hello.caesar(3)).to eq("khoor")
    end

    it "is careful of the letters at the end of the alphabet" do
      expect(zany.caesar(2)).to eq("bcpa")
    end
  end
end

describe Hash do
  subject(:hash_one) { { a: "alpha", b: "beta" } }
  subject(:hash_two) { { b: "bravo", c: "charlie" } }
  describe "#difference" do
    it "returns a new hash containing only the keys that appear in one or the other of the hashes (but not both!)" do
      expect(hash_one.difference(hash_two)).to eq({ a: "alpha", c: "charlie" })
    end
  end
end

describe Fixnum do
  describe "#stringify" do
    it "converts to base 10" do
      expect(5.stringify(10)).to eq("5")
      expect(234.stringify(10)).to eq("234")
    end

    it "converts to base 2" do
      expect(5.stringify(2)).to eq("101")
      expect(234.stringify(2)).to eq("11101010")
    end

    it "converts to base 16" do
      expect(234.stringify(2)).to eq("11101010")
      expect(234.stringify(16)).to eq("EA")
    end

    it "doen't call built in to_s" do
      expect(5.stringify(10)).not_to receive(:to_s)
    end
  end
end
