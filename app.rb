require "./algos"

grid = Boggle::Grid.new(:fr)
dict = Boggle::Dict.new("/home/n25/downloads/ods6.txt")
algo = Boggle::Algos::BruteForce.new(grid, dict)

puts grid
algo.solve
puts "#{algo.solutions.size} solutions found"
puts algo.solutions.to_a
