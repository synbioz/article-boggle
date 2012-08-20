require "./algos"

dict = Boggle::Dict.new("/home/n25/downloads/ods6.txt")

100.times do
  grid = Boggle::Grid.new(:fr)
  algo = Boggle::Algos::Subtil.new(grid, dict)
  algo.solve
end
