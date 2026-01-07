# typed: true
# frozen_string_literal: true

class Day6 < Solution
  def part_one
    @input
      .map { it.split(" ") }
      .transpose
      .sum do |line|
        if line.pop == "+"
          line.map(&:to_i).sum
        else
          line.map(&:to_i).reduce(&:*)
        end
      end
  end

  def part_two
    @input
      .map { it.chomp.split("") }
      .transpose
      .reduce([[0], nil]) do |memo, line|
        sum, operator = memo

        if line.all? { it == " " }
          [sum, nil]
        elsif operator.nil?
          operator = line.pop
          tmp = line.reject { it == " " }.join.to_i
          [sum << tmp, operator]
        else
          curr = line.reject { it == " " }.join.to_i
          case operator
          when "+"
            sum[-1] = sum[-1] + curr
            [sum, operator]
          when "*"
            sum[-1] = sum[-1] * curr
            [sum, operator]
          else
            raise "Expected operator but got #{operator}"
          end
        end
      end.first.sum
  end
end
