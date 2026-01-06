# typed: true
# frozen_string_literal: true

class Day5 < Solution
  def part_one
    ranges, ids = parse
    ids.count do |id|
      range = ranges.bsearch { it.first <= id }
      range && range.last >= id
    end
  end

  def part_two
    ranges, _ids = parse
    ranges.sum { it.last - it.first + 1 }
  end

  private

  def parse
    ranges, ids = @input.join("\n").split("\n\n").map { it.split("\n") }
    sorted_ranges =
      ranges
      .map { |range| range.split("-").map(&:to_i) }
      .sort_by(&:first)
      .reduce([]) do |memo, current|
        next memo << current if memo.empty?

        if memo.last.last >= current.first
          memo[-1] = [memo.last.first, [memo.last.last, current.last].max]
        else
          memo << current
        end
        memo
      end.reverse
    ids.map!(&:to_i)

    [sorted_ranges, ids]
  end
end
