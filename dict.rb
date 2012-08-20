module Boggle
  class Dict
    def initialize(filepath)
      @filepath = filepath
      @words = {}
      f = File.open(filepath, "r")
      f.each_line { |line| @words[line.chomp] = true if line.size > 3 }
      f.close
    end

    def exists?(word)
      @words[word] == true
    end

    def to_s
      "Dict:#{@filepath}"
    end
  end
end
