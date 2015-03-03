# 1. display a matrix of 10 x 10
# 2. insert random elements into the matrix and display it
# 3. ask if user wants a new random matrix and display if user said yes
# 4. generate a matrix of max 30 rows and max 100 columns, based on user input
    # with values only being ' ' and '0'
# 5. test if cells are alive or not (' ' is dead and '0' is alive)
# 6. apply rules of conways game of life = part 1
#   count living cells surrounding each element in matrix
# 7. apply rules of conways game of life - part 2
#   create new matrix with rules applied, display it and iterate it for 10 times
#   rules:
#     any live cell with fewer than two live neighbors dies, as if cause by under population.
#     any live cell with two or three live neighbors lves on to the newxt generation.
#     any live cell with more than three live neighbors dies, as if by overcrowding
#     any dead cell with exactly three live neightbors becomes a live cell, as if by reproductiion.

# extra 1. use n iterations
# extra 2. fix menus and presentation
# extra 3. let user decide what percentage of board to fill with '0' at teh beginning
# extra 4. move classe to files of their own.

class Cell
  attr_writer :neighbors

  def initialize(seed_probability)
    @alive = seed_probability > rand
  end

  def next!
    @alive = @alive ? (2..3) === @neighbors : 3 == @neighbors
  end

  def to_i
    @alive ? 1 : 0
  end

  def to_s
    @alive ? '0' : ' '
  end
end

class Game

  puts "-----------------------------------"
  puts "Welcome to Conway's Game of Life."
  puts "An automaton simulation game."
  puts "-----------------------------------"



  def initialize (height, width, seed_probability, generation)
    @height, @width, @generation = height, width, generation
    @cells = Array.new(height) {
      Array.new(width) { Cell.new(seed_probability) }
    }
  end

  def play!
    (1..@generation).each do
      next!
      system('clear')
      puts self
    end
  end

  def next!
    @cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell.neighbors = alive_neighbors(y,x)
      end
    end
    @cells.each { |row| row.each { |cell| cell.next! } }
  end

  def alive_neighbors(y,x)
    [[-1,0], [1,0], # sides
    [-1,1], [0,1], [1,1], # over
    [-1,-1], [0,-1], [1,-1] # under
  ].inject(0) do |sum, pos|
    sum + @cells[(y + pos[0]) % @height][(x + pos[1]) % @width].to_i
    end
  end

  def to_s
    @cells.map { |row| row.join }.join("\n")
  end
end

Game.new(100, 100, 0.1, 1000).play!
