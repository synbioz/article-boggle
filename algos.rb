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
        @cursor    = []
        @word      = ""
        @used      = (0...GRID_SIZE).map{ (0...GRID_SIZE).map{ false } }
      end

      def solve
        init_steps = (0...GRID_SIZE * GRID_SIZE).map{ |n| [n / GRID_SIZE, n % GRID_SIZE] }
        explore!(init_steps)
      end

      private

      def explore!(steps)
        steps.each do |coord|
          move_to!(coord)
          @solutions << @word if @word.size >= 3 && @dict.exists?(@word)
          explore!(next_steps)
          move_back!
        end
      end

      def next_steps
        i, j   = @cursor.last
        coords = [[i-1, j], [i, j-1], [i-1, j-1], [i+1, j], [i, j+1], [i+1, j+1], [i-1, j+1], [i+1, j-1]]
        coords.delete_if do |coord|
          i, j = coord
          i >= GRID_SIZE || i < 0 || j >= GRID_SIZE || j < 0 || @used[i][j] == true
        end
      end

      def move_to!(coord)
        @cursor << coord
        @word += @grid.matrix[coord[0]][coord[1]]
        @used[coord[0]][coord[1]] = true
      end

      def move_back!
        i, j        = @cursor.pop
        @word       = @word[0..-2]
        @used[i][j] = false
      end
    end
  end
end
