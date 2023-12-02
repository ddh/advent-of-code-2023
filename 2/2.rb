# Part 1:
# Given: 12 red, 13 green, 14 blue

components = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}

valid_game_ids = []

games = File.readlines("2/input.txt", chomp: true)
games.each do |game|
  id, game = game.split(': ') # ["Game 1", "6 green, 3 blue; 3 red, 1 green; 4 green, 3 red, 5 blue"]
  id = id.delete("^0-9").to_i # 1
  sets = game.split('; ') # ["6 green, 3 blue", "3 red, 1 green", "4 green, 3 red, 5 blue"]

  valid_game = true
  sets.each do |set|
    set.split(', ').each do |component| # ["6 green", "3 blue"]
      count, color = component.split(" ") # ["6", "green"]
      valid_game = false if components[color] < count.to_i # 13 < 6
    end
  end
  valid_game_ids << id if valid_game
end

p valid_game_ids.sum

# Part 2:
# Find min number of cubes needed to make each game possible

powers = 0
games = File.readlines("2/input.txt", chomp: true)
games.each do |game|
  min_components = {
    "green" => 1,
    "red" => 1,
    "blue" => 1
  }

  # Traverse each set and find the min needed for each color
  sets = game.split(': ')[1].split('; ') # ["6 green, 3 blue", "3 red, 1 green", "4 green, 3 red, 5 blue"]
  sets.each do |set|
    components = set.split(', ')
    components.each do |component|
      count, color = component.split(' ')
      min_components[color] = [min_components[color], count.to_i].max
    end
  end

  # Find the power (red * green * blue)
  powers += min_components.values.inject(:*)
end

p powers
