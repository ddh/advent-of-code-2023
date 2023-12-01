
# Part 1
 lines = File.read(File.join(__dir__, "input.txt")).split

 answer = lines.sum do |line|
  number_string = line.delete("^0-9")
  "#{number_string[0]}#{number_string[-1]}".to_i
 end

 p answer

#  Part 2
#  words are now valid digits.
#  approach: try gsubbing them and replace with corresponding number
#  tricky: twoneight should be 218. Take care in the overlaps.

MAP = {
  "one" => "one1one",
  "two" => "two2two",
  "three" => "three3three",
  "four" => "four4four",
  "five" => "five5five",
  "six" => "six6six",
  "seven" => "seven7seven",
  "eight" => "eight8eight",
  "nine" => "nine9nine",
}

lines = File.read(File.join(__dir__, "input.txt")).split

answer = lines.sum do |line|
  MAP.each_pair {|word, num| line.gsub!(word, num)}
  number_string = line.delete("^0-9")
  "#{number_string[0]}#{number_string[-1]}".to_i
end

p answer
