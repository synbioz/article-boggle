require './language'

module Boggle
  GRID_SIZE = 3

  class Grid
    attr_reader :lang, :matrix

    def initialize(lang_sym)
      @lang   = lang_sym
      @matrix = (0...GRID_SIZE).map{(0...GRID_SIZE).map{Language.letter(@lang)}}
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
