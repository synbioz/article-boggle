require "algorithms"

class Containers::Trie
  def prefix?(string)
    string = string.to_s
    return false if string.empty?
    recursive_prefix?(@root, string, 0)
  end

  def recursive_prefix?(node, string, index)
    return false if node.nil?
    char = string[index]
    if (char < node.char)
      recursive_prefix?(node.left, string, index)
    elsif (char > node.char)
      recursive_prefix?(node.right, string, index)
    else
      return true if index == (string.length - 1)
      recursive_prefix?(node.mid, string, index + 1)
    end
  end
end

module Boggle
  class Dict
    def initialize(filepath)
      @trie = Containers::Trie.new
      f = File.open(filepath, "r")
      f.each_line { |line| @trie[line.chomp] = true if line.size > 3 }
      f.close
    end

    def exists?(word)
      return @trie.has_key?(word)? :found : :prefix if @trie.prefix?(word)
      :not_found
    end

    def to_s
      "Dict:#{@filepath}"
    end
  end
end
