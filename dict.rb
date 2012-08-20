require "algorithms"

module Boggle
  class Dict
    def initialize(filepath)
      @filepath = filepath
      @words = File.readlines(filepath).map(&:chomp)
    end

    def exists?(word)
      @words.each do |w|
        return (w == word ? :found : :prefix) if w.start_with?(word)
      end
      return :not_found
    end

    def to_s
      "Dict:#{@filepath}"
    end
  end
end
