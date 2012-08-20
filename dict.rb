module Boggle
  class Dict
    def initialize(filepath)
      @filepath = filepath
      @words = File.readlines(filepath).map(&:chomp).delete_if{|w| w.size < 3}
    end

    def exists?(word)
      @words.include?(word)
    end

    def to_s
      "Dict:#{@filepath}"
    end
  end
end
