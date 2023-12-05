# Part 1
cards = File.readlines("4/input.txt", chomp: true)

p (cards.sum do |card|
  numbers_only = card.split(': ')[1].delete('|').split(' ').map(&:to_i)
  matches = numbers_only.tally.filter { |k, v| v == 2 }.count
  matches > 0 ? 2 ** (matches - 1) : 0
end)
