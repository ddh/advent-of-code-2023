# Part 2
cards = File.readlines("4/input.txt", chomp: true)
copies = {}
cards.length.times { |a| copies[a] = 1 }

cards.each_with_index do |card, card_idx|
  numbers_only = card.split(': ')[1].delete('|').split(' ').map(&:to_i)
  matches = numbers_only.tally.filter { |k, v| v == 2 }.count
  copies[card_idx].times do
    matches.times do |match_idx|
      copies[card_idx + match_idx + 1] += 1
    end
  end
end

p copies.values.sum
