# Creates 2D array given a matrix
def graph_from_input(file)
  lines = File.readlines(file, chomp: true)
  lines.map(&:chars)
end

def is_digit?(char)
  !!(char.match /\d/)
end

def is_period?(char)
  char == '.'
end

def is_symbol?(char)
  !is_period?(char) && !is_digit?(char)
end

class Point
  attr_accessor :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end
end

# graph -> 2D array
# point_start -> Point
# point_end -> Point
def adjacent?(graph, point_start, point_end)
  # Check top row for symbols
  if point_start.row - 1 >= 0
    ([point_start.col - 1, 0].max..[point_end.col + 1, graph.first.length - 1].min).each do |col|
      return true if is_symbol?(graph[point_start.row - 1][col])
    end
  end

  # Check bottom row for symbols
  if point_start.row + 1 < graph.length
    ([point_start.col - 1, 0].max..[point_end.col + 1, graph.first.length - 1].min).each do |col|
      return true if is_symbol?(graph[point_start.row + 1][col])
    end
  end

  # Check cell left of row
  if point_start.col > 0
    return true if is_symbol?(graph[point_start.row][point_start.col - 1])
  end

  # Check cell right of row
  if point_end.col + 1 < graph.first.length
    return true if is_symbol?(graph[point_start.row][point_end.col + 1])
  end

end

# Part 1: Find numbers that are adjacent to symbol in a 2D array

answers = []
number = ''
# graph = graph_from_input('3/sample.txt')
graph = graph_from_input('3/input.txt')
row = 0
col = 0

while row < graph.length
  while col < graph.first.length
    cell_val = graph[row][col]
    if is_digit?(cell_val)
      number << cell_val
      adjacency_point_start = Point.new(row, col) unless adjacency_point_start

      # When we hit the end of row or when the next cell is not a digit:
      if col == graph.first.length - 1 or !is_digit?(graph[row][col + 1])
        adjacency_point_end = Point.new(row, col)
        answers << number.to_i if adjacent?(graph, adjacency_point_start, adjacency_point_end)
        adjacency_point_start = nil
        number = ''
      end
    end
    col += 1 # Move to next col
  end
  col = 0 # Reset col ptr
  row += 1 # Move to next row
end

p answers.sum
