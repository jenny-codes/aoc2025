# typed: true
# frozen_string_literal: true

class Day4 < Solution
  PAPER = "@"
  EMPTY = "."

  Point = Data.define(:row, :col, :val)

  def part_one
    pad_input!
    construct_points!
    grids = @input.each_cons(3).flat_map do |rows|
      rows.map { |row| row.each_cons(3).to_a }.transpose
    end

    grids.count do |grid|
      grid[1][1].val == PAPER && grid.flatten.count { it.val == PAPER } - 1 < 4
    end
  end

  def part_two
    tally = 0
    loop do
      removed = remove
      tally += removed
      break if removed.zero?
    end

    tally
  end

  private

  #: -> Integer
  def remove
    grids = @input.each_cons(3).flat_map do |rows|
      rows.map { |row| row.each_cons(3).to_a }.transpose
    end

    removed_count = 0
    grids.each do |grid|
      center = grid[1][1]
      next unless center.val == PAPER

      if grid.flatten.count { it.val == PAPER } - 1 < 4
        @input[center.row][center.col] = center.with(val: EMPTY)
        removed_count += 1
      end
    end

    removed_count
  end

  def pad_input!
    @input.map! { it.split("") }
    width = @input.first.count
    @input.map! { it.unshift(EMPTY).append(EMPTY) }
    @input
      .unshift([EMPTY] * (width + 2))
      .append([EMPTY] * (width + 2))
  end

  def construct_points!
    @input = @input.each_with_index.map do |row, row_idx|
      row.each_with_index.map do |val, col_idx|
        Point.new(row_idx, col_idx, val)
      end
    end
  end
end
