require 'set'

require './grid'
require './dict'

module Boggle
  module Algos
    class BruteForce
      attr_reader :solutions

      def initialize(grid, dict)
        @grid      = grid
        @dict      = dict
        @solutions = Set.new
      end

      def solve
        (0...GRID_SIZE).each do |i|
          (0...GRID_SIZE).each do |j|
            @cursor = [[i, j]]
            @word   = @grid.matrix[i][j]
            explore!
          end
        end
      end

      private

      def explore!
        next_steps.each do |coord|
          move_to!(coord)
          @solutions << @word if @word.size >= 3 && @dict.exists?(@word)
          explore!
          move_back!
        end
      end

      def next_steps
        i, j   = @cursor.last
        coords = [[i-1, j], [i, j-1], [i-1, j-1], [i+1, j], [i, j+1], [i+1, j+1], [i-1, j+1], [i+1, j-1]]
        coords.delete_if do |coord|
          i, j = coord
          i >= GRID_SIZE || i < 0 || j >= GRID_SIZE || j < 0 || @cursor.include?(coord)
        end
      end

      def move_to!(coord)
        @cursor << coord
        @word += @grid.matrix[coord[0]][coord[1]]
      end

      def move_back!
        @cursor.pop
        @word = @word[0..-2]
      end
    end
  end
end
