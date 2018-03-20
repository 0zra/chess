require_relative 'table'
require_relative 'pieces'

def domain_of color,board #the board , i.e. table.state, not table
  domain = []
  board.each do |r,v|

    v.each_with_index do |v,c|
      if v != nil
        figurine = piece v
        options = []
        helper = r.to_s + (c+1).to_s
        options = pawn(helper,board) if figurine[0] == "pawn" && figurine[1] == color
        options = knight(helper,board) if figurine[0] == "knight" && figurine[1] == color
        options = rook(helper,board) if figurine[0] == "rook" && figurine[1] == color
        options = bishop(helper,board) if figurine[0] == "bishop" && figurine[1] == color
        options = queen(helper,board) if figurine[0] == "queen" && figurine[1] == color
        options = king_basic(helper,board) if figurine[0] == "king" && figurine[1] == color
        domain = domain + options
      end
    end
  end
  return domain.uniq
end

class Player
  attr_accessor :color, :king_location, :check
  def initialize color
    @color = color
    @check = false
    @king_location = "H4" if color == "black"
    @king_location = "A5" if color == "white"
  end
  def is_in_check? board
    if domain_of(@color.switch,board).include?(@king_location)
      @check = true
    else
      @check = false
    end
  end
end
table = Table.new
table.print_table
white = Player.new("white")
black = Player.new("black")
player = "white"

# The game itself
=begin
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
=end
