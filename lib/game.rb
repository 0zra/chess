require_relative 'table'
require_relative 'pieces'

table = Table.new
table.print_table
player = "white"


while true
  puts "Choose your move (#{player})"
  player_move = gets.chomp
  from = player_move[0..1]
  to = player_move[-2..-1]

  if(table.state[from[0].to_sym][(from[1].to_i) -1]) == nil
    puts "You chose the wrong piece"
    next
  elsif piece(table.state[from[0].to_sym][(from[1].to_i) -1])[1] != player
    puts "You cheater!"
    next
  elsif is_legal?(from,to,table.state)
    table.move from, to
    system('clear')
  else
    puts "That is illegal!"
    next
  end
  player = player.switch

  table.print_table
end
