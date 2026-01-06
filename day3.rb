# frozen_string_literal: true

require "./solution"

class Day3 < Solution
  def part_one
    digits = @input.map do |bank|
      bank.each_char.map(&:to_i).reduce([0, 0]) do |prev, curr|
        if prev.first < prev.last
          prev[0] = prev.last
          prev[1] = curr
        elsif prev.last < curr
          prev[1] = curr
        end
        prev
      end
    end
    digits.sum { |first, second| first * 10 + second }
  end

  def part_two
    digits = @input.map do |bank|
      bank.each_char.map(&:to_i).reduce([0] * 12) do |prev, curr|
        # Find the index of such a pair where the first is less than the second
        switch_index = prev.each_cons(2).to_a.index do |pair|
          pair.first < pair.last
        end

        if switch_index
          prev.delete_at(switch_index)
          prev.append(curr)
        elsif prev.last < curr
          prev[-1] = curr
        end
        prev
      end
    end
    digits.sum { it.join.to_i }
  end
end
