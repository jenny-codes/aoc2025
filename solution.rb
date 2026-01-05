# typed: strict
# frozen_string_literal: true

class Solution
  #: (String, String) -> Solution
  def self.for(day, input)
    Object.const_get(day.capitalize).new(input)
  end

  #: ([String]) -> void
  def initialize(input)
    @input = input
  end

  #: -> void
  def part_one
    raise "Need to implement :part_one function"
  end

  #: -> void
  def part_two
    raise "Need to implement :part_two function"
  end
end
