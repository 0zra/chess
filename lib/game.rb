require_relative 'table'
require_relative 'pieces'

table = Table.new
table.print_table
while true
  puts "Choose your move"
  player_move = gets.chomp
  from = player_move[0..1]
  to = player_move[-2..-1]
  table.move from, to
  system('clear')
  table.print_table
end
