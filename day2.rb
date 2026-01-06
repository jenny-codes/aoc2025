# frozen_string_literal: true

require "./solution"

class Day2 < Solution
  def part_one
    sum = 0

    @input
      .first
      .split(",")
      .map { |raw| raw.split("-").map(&:to_i) }
      .each do |start, finish|
        current = start
        while current <= finish
          sum += current if valid?(current)
          current = find_next_valid(current)
        end
    end

    sum
  end

  def part_two
    sum = 0

    @input
      .first
      .split(",")
      .map { |raw| raw.split("-").map(&:to_i) }
      .each do |start, finish|
        current = start
        while current <= finish
          sum += current if valid_p2?(current)
          current = find_next_valid_p2(current)
        end
    end

    sum
  end

  private

  def valid?(num)
    count = num.digits.count
    count.even? && (num / 10**(count / 2) == num % 10**(count / 2))
  end

  def find_next_valid(num)
    digits = num.digits.reverse
    count = digits.count
    if count.even?
      first_half = num / 10**(count / 2)
      second_half = num % 10**(count / 2)
      half = if first_half > second_half
               first_half
             else
               first_half + 1
             end

      half * 10**(count / 2) + half
    else
      10**count + 10**(count / 2)
    end
  end

  def valid_p2?(num)
    count = num.digits.count
    divisors_for_repetition(count).any? do |slice_size|
      num.digits.reverse.each_slice(slice_size).map(&:join).uniq.size == 1
    end
  end

  def find_next_valid_p2(num)
    count = num.digits.count
    candidates = divisors_for_repetition(count).map do |slice_size|
      repetitions = count / slice_size
      first = num.digits.reverse.take(slice_size).join

      candidate_with_first = (first * repetitions).to_i
      if candidate_with_first <= num
        ((first.to_i + 1).to_s * repetitions).to_i
      else
        candidate_with_first
      end
    end

    candidates.append(10**count).min
  end

  def divisors_for_repetition(n)
    (1..n / 2).select { |d| (n % d).zero? }
  end
end
