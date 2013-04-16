require "./algos"

# Usage: echo 'ABCD EFGH IJKL MNOP' | bundle exec ruby solve.rb

dict   = Boggle::Dict.new("/home/n25/downloads/ods6.txt")
matrix = STDIN.gets.chomp.split(' ', 4).map{ |line| line.split('', 4) }
grid   = Boggle::Grid.new(:fr, matrix)
algo   = Boggle::Algos::Subtil.new(grid, dict)

puts "== Solving =="
matrix.each{ |l| puts l.join(' ') }


algo.solve

puts "== #{algo.solutions.size} solutions found =="
algo.solutions.to_a.sort.each{ |s| puts s }
