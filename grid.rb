require './language'

module Boggle
  GRID_SIZE = 4
  NEIGHBORS = (0...GRID_SIZE).map do |i|
    (0...GRID_SIZE).map do |j|
      coords = [[i-1, j], [i, j-1], [i-1, j-1], [i+1, j],
                [i, j+1], [i+1, j+1], [i-1, j+1], [i+1, j-1]]
      coords.delete_if do |coord|
        a, b = coord
        a >= GRID_SIZE || a < 0 || b >= GRID_SIZE || b < 0
      end
    end
  end

  class Grid
    attr_reader :lang, :word

    def initialize(lang_sym, matrix=nil)
      @lang   = lang_sym
      @matrix = matrix || (0...GRID_SIZE).map{(0...GRID_SIZE).map{Language.letter(@lang)}}
      @cursor = []
      @word   = ""
      @used   = (0...GRID_SIZE).map{ (0...GRID_SIZE).map{ false } }
    end

    def next_steps
      i, j = @cursor.last
      NEIGHBORS[i][j].reject { |coord| @used[coord[0]][coord[1]] }
    end

    def move_to!(coord)
      @cursor << coord
      @word += @matrix[coord[0]][coord[1]]
      @used[coord[0]][coord[1]] = true
    end

    def move_back!
      i, j        = @cursor.pop
      @word       = @word[0..-2]
      @used[i][j] = false
    end

    def to_s
      s = ""
      @matrix.each do |line|
        line.each do |cell|
          s += cell
        end
        s += "\n"
      end
      s
    end
  end

end
