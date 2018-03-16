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

def is_ok? adress
  r = adress[0].to_sym
  c = adress[1].to_i
  return false if r < :A || r>:H
  return false if c <1 || c > 8
  return true
end


 def pawn adress, board
   r = adress[0].to_sym
   c = adress[1].to_i
   possible_moves = []
   helper = piece board[r][c]
   color = helper[1]
   if color == "white"
     possible_moves<< r.plus.to_s + c.to_s if board[r.plus][c] ==nil
      if board[r.plus][c+1] != nil && (piece board[r.plus][c+1])[1] == "black"
        helper = r.plus.to_s + (c+1).to_s
        possible_moves<< helper if is_ok? helper
      end
      if board[r.plus][c-1] != nil && (piece board[r.plus][c-1])[1] == "black"
        helper = r.plus.to_s + (c-1).to_s
         possible_moves<< r.plus.to_s + (c-1).to_s if is_ok? helper
      end
   else
   end
   return possible_moves
 end
