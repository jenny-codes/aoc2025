# typed: true
# frozen_string_literal: true

require "./solution"

class Day1 < Solution
  INITIAL_VALUE = 50
  def part_one
    count = 0
    @input
      .map { |item| T.must(/(\w)(\d+)/.match(item)).captures }
      .map { |direction, distance| direction == "R" ? distance.to_i : -distance.to_i }
      .reduce(INITIAL_VALUE) do |memo, instruction|
        memo = (memo + instruction) % 100
        count += 1 if memo.zero?
        memo
      end
    count
  end

  def part_two
    count = 0
    @input
      .map { |item| T.must(/(\w)(\d+)/.match(item)).captures }
      .map { |direction, distance| direction == "R" ? distance.to_i : -distance.to_i }
      .reduce(INITIAL_VALUE) do |memo, instruction|
        raw = memo + instruction
        if raw.zero?
          count += 1
        elsif raw < 0
          count += -raw / 100
          count += 1 unless memo.zero?
        else
          count += raw / 100
        end

        raw % 100
      end
    count
  end
end
