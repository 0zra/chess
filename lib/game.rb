require_relative 'table'
require_relative 'pieces'
require 'yaml'

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
  def king_relocation to
    @king_location = to
  end

  def king_advace board
    return  king_basic("E8",board) -domain_of(@color.switch,board)
  end
end
puts %{Ok, let's see
  I know no one is ever going to play this
  (and just a handful of people is going to see this code)
  but just in case that someone is actually this crazy (XD)
  I'll explaint the basic rules

  Basic rules of chess apply (but not all, see README)
  to move your piece write the coordinates of the piece you'd
  like to move and coordinates to which you'd like it to be moved to
  (is this even grammatically correct - btw sry for awful spelling, atom does not have a spellcheck XD)
  e.g. 'B2 to D2' will move the white pawn from B2 position to D2 position
  ! mind the capital letters of the rows (actually it is best to just use caps lock on this one)

  If at any time you'd like to save your game or load a saved game instead of
  typing coordinates tipe load or save 

  Enjoy! :D

}
table = Table.new
table.print_table
white = Player.new("white")
black = Player.new("black")
player = {"white" => white, "black" => black}
playing  = "white"

# The game itself

while true
  puts "Choose your move (#{player[playing].color})"
  player_move = gets.chomp
  if player_move.include?("load") || player_move.include?("Load") || player_move.include?("LOAD") #I know I've could have done this more easily with REGEX but didn't feel like it X)
    load_game = YAML.load(File.read("saves.yaml"))
    player = load_game[:player]
    playing = load_game[:playing]
    table.state = load_game[:table]
    table.print_table

    next
  end
  if player_move.include?("save") || player_move.include?("Save") || player_move.include?("SAVE")
    save = {playing: playing, player: player, table: table.state}
    File.open("saves.yaml","w") {|file|  file.write(save.to_yaml)}
    next
  end
  from = player_move[0..1]
  to = player_move[-2..-1]

  if(table.state[from[0].to_sym][(from[1].to_i) -1]) == nil
    puts "You chose the wrong piece"
    next
  elsif piece(table.state[from[0].to_sym][(from[1].to_i) -1])[1] != playing
    puts "You cheater!"
    next
  elsif is_legal?(from,to,table.state)
    player[playing].king_relocation(to) if(table.state[from[0].to_sym][(from[1].to_i) -1] == "\u2654" || table.state[from[0].to_sym][(from[1].to_i) -1] ==  "\u265A")
    table.move from, to
    system('clear')

    if player[playing].is_in_check? table.state
      puts "CHECK MATE, #{player[playing.switch].color.capitalize} HAS WON"
      table.print_table
      exit
    end
    puts "CHECK" if player[playing.switch].is_in_check? table.state

  else
    puts "That is illegal!"
    next
  end
  playing = playing.switch

  table.print_table
end
