require 'set'

require './grid'
require './dict'

module Boggle
  module Algos
    class BruteForce
      attr_reader :solutions, :grid

      def initialize(grid, dict)
        @grid      = grid
        @dict      = dict
        @solutions = Set.new
      end

      def solve
        init_steps = (0...GRID_SIZE * GRID_SIZE).map{ |n| [n / GRID_SIZE, n % GRID_SIZE] }
        explore!(init_steps)
      end

      private

      def explore!(steps)
        steps.each do |coord|
          grid.move_to!(coord)
          @solutions << grid.word if grid.word.size >= 3 && @dict.exists?(grid.word)
          explore!(grid.next_steps)
          grid.move_back!
        end
      end
    end

    class Subtil
      attr_reader :solutions, :grid

      def initialize(grid, dict)
        @grid      = grid
        @dict      = dict
        @solutions = Set.new
      end

      def solve
        init_steps = (0...GRID_SIZE * GRID_SIZE).map{ |n| [n / GRID_SIZE, n % GRID_SIZE] }
        explore!(init_steps)
      end

      private

      def explore!(steps)
        steps.each do |coord|
          grid.move_to!(coord)
          case @dict.exists?(grid.word)
          when :found
            @solutions << grid.word
            explore!(grid.next_steps)
          when :prefix
            explore!(grid.next_steps)
          else
            # do nothing
          end
          grid.move_back!
        end
      end
    end
  end
end
