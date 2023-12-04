# Creates 2D array given a matrix
def graph_from_input(file)
  lines = File.readlines(file, chomp: true)
  lines.map(&:chars)
end

def is_digit?(char)
  !!(char.match /\d/)
end

def is_asterisk?(char)
  char == '*'
end

class Point
  attr_accessor :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def ==(other)
    row == other.row && col == other.col
  end

  def eql?(other)
    self == other
  end

  def hash
    [row, col].hash
  end
end

# graph -> 2D array
# point_start -> Point
# point_end -> Point
def adjacent?(graph, point_start, point_end, number, map)
  # Check top row for symbols
  if point_start.row - 1 >= 0
    ([point_start.col - 1, 0].max..[point_end.col + 1, graph.first.length - 1].min).each do |col|
      map[Point.new(point_start.row - 1, col)] = Array(map[Point.new(point_start.row - 1, col)]).push(number) if is_asterisk?(graph[point_start.row - 1][col])
    end
  end

  # Check bottom row for symbols
  if point_start.row + 1 < graph.length
    ([point_start.col - 1, 0].max..[point_end.col + 1, graph.first.length - 1].min).each do |col|
      map[Point.new(point_start.row + 1, col)] = Array(map[Point.new(point_start.row + 1, col)]).push(number) if is_asterisk?(graph[point_start.row + 1][col])
    end
  end

  # Check cell left of row
  if point_start.col > 0
    map[Point.new(point_start.row, point_start.col - 1)] = Array(map[Point.new(point_start.row, point_start.col - 1)]).push(number) if is_asterisk?(graph[point_start.row][point_start.col - 1])
  end

  # Check cell right of row
  if point_end.col + 1 < graph.first.length
    map[Point.new(point_start.row, point_start.col + 1)] = Array(map[Point.new(point_start.row, point_start.col + 1)]).push(number) if is_asterisk?(graph[point_start.row][point_start.col + 1])
  end

end

# Part 1: Find numbers that are adjacent to symbol in a 2D array

answers = []
number = ''
# graph = graph_from_input('3/sample.txt')
graph = graph_from_input('3/input.txt')
row = 0
col = 0
map = {}


# 1.  Iterate through each cell, finding all the numbers
#     When number is found, scan around the number and look for '*'
#     If '*' is found, map the location of the '*' as a Point in a hashmap
#     where the value is an array of numbers adjacent to that '*'
while row < graph.length
  while col < graph.first.length
    cell_val = graph[row][col]
    if is_digit?(cell_val)
      number << cell_val
      adjacency_point_start = Point.new(row, col) unless adjacency_point_start

      # When we hit the end of row or when the next cell is not a digit:
      if col == graph.first.length - 1 or !is_digit?(graph[row][col + 1])
        adjacency_point_end = Point.new(row, col)
        adjacent?(graph, adjacency_point_start, adjacency_point_end, number, map)
        adjacency_point_start = nil
        number = ''
      end
    end
    col += 1 # Move to next col
  end
  col = 0 # Reset col ptr
  row += 1 # Move to next row
end

# 2.  With hashmap of '*' locations (via Point) and array of numbers in hand,
#     filter out only key-values where the value is EXACTLY 2 numbers

map.filter! { |k,v| v.count == 2 }

# 3.  Now the hashmap only contains '*' Points with EXACTLY 2 numbers, multiply the values


map.transform_values! {|v| v.map(&:to_i).inject(:*)}

# 4. Then sum up all the values for the answers
p map.values.sum
