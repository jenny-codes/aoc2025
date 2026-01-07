# typed: true
# frozen_string_literal: true

class Day7 < Solution
  START = "S"
  SPLITTER = "^"

  def part_one
    map = @input.map { it.split("") }

    split_count = 0
    beams = Set.new([map.first.index(START)])
    map[1..].each do |row|
      split_beams = beams.select { |col| row[col] == SPLITTER }
      new_beams = split_beams.flat_map { [it + 1, it - 1] }
      beams.merge(new_beams)
      beams.subtract(split_beams)
      split_count += split_beams.count
    end
    p beams

    split_count
  end

  def part_two
    map = @input.map { it.split("") }
    beams = Hash.new { |h, k| h[k] = 0 }
    beams[map.first.index(START)] = 1
    map[1..].each do |row|
      split_beams = beams.select { |col, _path| row[col] == SPLITTER }
      new_beams = split_beams.flat_map { |col, path| [[col + 1, path], [col - 1, path]] }
      split_beams.each { beams.delete(it.first) }
      new_beams.each { |col, path| beams[col] += path }
    end
    beams.values.sum
  end
end
