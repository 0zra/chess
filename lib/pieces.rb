require_relative 'helper'
def piece location
  return ["king","black"] if location == "\u2655"
  return ["queen","black"] if location == "\u2654"
  return ["bishop","black"] if location == "\u2657"
  return ["knight","black"] if location =="\u2658"
  return ["rook","black"] if location == "\u2655"
  return ["pawn","black"] if location == "\u2659"
  return ["king","white"] if location == "\u265A"
  return ["queen","white"] if location == "\u265B"
  return ["bishop","white"] if location == "\u265D"
  return ["knight","white"] if location == "\u265E"
  return ["rook","white"] if location == "\u265C"
  return ["pawn","white"] if location == "\u265F"
end




 def pawn adress, board
   r = adress[0].to_sym
   c = adress[1].to_i
   possible_moves = []
   helper = piece board[r][c]
   color = helper[1]
   if color == "white"
     possible_moves<< r.plus.to_s + c.to_s
   else
   end
   return possible_moves
 end
