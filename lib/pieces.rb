require_relative 'helper'
def piece location
  return ["king","black"] if location == "\u2654"
  return ["queen","black"] if location == "\u2655"
  return ["bishop","black"] if location == "\u2657"
  return ["knight","black"] if location =="\u2658"
  return ["rook","black"] if location == "\u2656"
  return ["pawn","black"] if location == "\u2659"
  return ["king","white"] if location == "\u265A"
  return ["queen","white"] if location == "\u265B"
  return ["bishop","white"] if location == "\u265D"
  return ["knight","white"] if location == "\u265E"
  return ["rook","white"] if location == "\u265C"
  return ["pawn","white"] if location == "\u265F"
  return ["nesto ne valja", "cudno"]
end
def is_occupied_by_enemy? poz, color
  return false if poz == nil
  helper =  piece poz
  return true if helper[1] != color
  return false
end
def is_occupied_by_friend? poz, color
  helper =  piece poz
  return false if helper == nil
  return true if helper[1] == color
  return false
end
def is_ok? adress
  return false if adress.size > 2
  r = adress[0].to_sym
  c = adress[1].to_i
  return false if r < :A || r>:H
  return false if c <1 || c > 8
  return true
end


 def pawn adress, board
   r = adress[0].to_sym
   c = adress[1].to_i
   c-=1
   possible_moves = []
   helper = piece board[r][c]
   color = helper[1]
   if color == "white"
     possible_moves<< r.plus.to_s + (c+1).to_s if board[r.plus][c] ==nil && (is_ok? r.plus.to_s + (c+1).to_s)
      if board[r.plus][c+1] != nil && (piece board[r.plus][c+1])[1] == "black"
        helper = r.plus.to_s + (c+2).to_s
        possible_moves<< helper if is_ok? helper
      end
      if board[r.plus][c-1] != nil && (piece board[r.plus][c-1])[1] == "black"
        helper = r.plus.to_s + (c).to_s
         possible_moves<< helper if is_ok? helper
      end
      if r.to_s == "B"
        possible_moves << r.plus.plus.to_s + (c+1).to_s if (board[r.plus][c] ==nil && board[r.plus.plus][c] == nil)
      end
    elsif color == "black"
      possible_moves << r.minus.to_s + (c+1).to_s if board[r.minus][c] ==nil && (is_ok? "#{r.minus}#{c+1}")
      if board[r.minus][c+1] != nil && (piece board[r.minus][c+1])[1] == "white"
        helper = r.minus.to_s + (c+2).to_s
        possible_moves<< helper if is_ok? helper
      end
      if board[r.minus][c-1] != nil && (piece board[r.minus][c-1])[1] == "white"
        helper = r.minus.to_s + (c).to_s
         possible_moves<< helper if is_ok? helper
      end
      if r.to_s == "G"
        possible_moves << r.minus.minus.to_s + (c+1).to_s if (board[r.minus][c] ==nil && board[r.minus.minus][c] == nil)
      end
    end
   return possible_moves
   # dodaj  en passan
 end

def knight adress, board
  r = adress[0].to_sym
  c = adress[1].to_i
  c -= 1
  possible_moves = []
  helper = piece board[r][c]
  color = helper[1]
  if is_ok? (r.plus.to_s + (c+3).to_s)
    possible_moves<<r.plus.to_s + (c+3).to_s if !is_occupied_by_friend?(board[r.plus][c+2],color)
  end
  if is_ok? (r.plus.to_s + (c-1).to_s)
    possible_moves<<r.plus.to_s + (c-1).to_s if !is_occupied_by_friend?(board[r.plus][c-2],color)
  end
  if is_ok? (r.plus.plus.to_s + (c+2).to_s)
    possible_moves<<r.plus.plus.to_s + (c+2).to_s if !is_occupied_by_friend?(board[r.plus.plus][c+1],color)
  end
  if is_ok? (r.plus.plus.to_s + (c).to_s)
    possible_moves<<r.plus.plus.to_s + (c).to_s if !is_occupied_by_friend?(board[r.plus.plus][c-1],color)
  end
  if is_ok? (r.minus.to_s + (c+3).to_s)
    possible_moves<<r.minus.to_s + (c+3).to_s if !is_occupied_by_friend?(board[r.minus][c+2],color)
  end
  if is_ok? (r.minus.to_s + (c-1).to_s)
    possible_moves<<r.minus.to_s + (c-1).to_s if !is_occupied_by_friend?(board[r.minus][c-2],color)
  end
#
  if is_ok? (r.minus.minus.to_s + (c+2).to_s)
    possible_moves<<r.minus.minus.to_s + (c+2).to_s if !is_occupied_by_friend?(board[r.minus.minus][c+1],color)
  end
  if is_ok? (r.minus.minus.to_s + (c).to_s)
    possible_moves<<r.minus.minus.to_s + (c).to_s if !is_occupied_by_friend?(board[r.minus.minus][c-1],color)
  end

  return possible_moves
end

def rook adress, board
  r = adress[0].to_sym
  c = adress[1].to_i
  c -= 1
  possible_moves = []
  helper = piece board[r][c]
  color = helper[1]
  while true
    if is_ok?(r.minus.to_s + (c+1).to_s)
      if board[r.minus][c]==nil
        possible_moves<<r.minus.to_s + (c+1).to_s
        r = r.minus
        next
      else
        break if is_occupied_by_friend?(board[r.minus][c],color)
        if is_occupied_by_enemy?(board[r.minus][c],color)
          possible_moves<<r.minus.to_s + (c+1).to_s
          break
        end
      end
    else
      break
    end
  end
  r = adress[0].to_sym
  while true
    if is_ok?(r.plus.to_s + (c+1).to_s)
      if board[r.plus][c]==nil
        possible_moves<<r.plus.to_s + (c+1).to_s
        r = r.plus
        next
      else
        break if is_occupied_by_friend?(board[r.plus][c],color)
        if is_occupied_by_enemy?(board[r.plus][c],color)
          possible_moves<<r.plus.to_s + (c+1).to_s
          break
        end
      end
    else
      break
    end
  end
  r = adress[0].to_sym
  while true
    if is_ok?(r.to_s + (c+2).to_s)
      if board[r][c+1]==nil
        possible_moves<<r.to_s + (c+2).to_s
        c+=1
        next
      else
        break if is_occupied_by_friend?(board[r][c+1],color)
        if is_occupied_by_enemy?(board[r][c+1],color)
          possible_moves<<r.to_s + (c+2).to_s
          break
        end
      end
    else
      break
    end
  end
  c = adress[1].to_i
  c -= 1
  while true
    if is_ok?(r.to_s + (c).to_s)
      if board[r][c-1]==nil
        possible_moves<<r.to_s + (c).to_s
        c-=1
        next
      else
        break if is_occupied_by_friend?(board[r][c-1],color)
        if is_occupied_by_enemy?(board[r][c-1],color)
          possible_moves<<r.to_s + (c).to_s
          break
        end
      end
    else
      break
    end
  end
 return possible_moves

end

def bishop adress, board
  r = adress[0].to_sym
  c = adress[1].to_i
  c -= 1
  possible_moves = []
  helper = piece board[r][c]
  color = helper[1]

  while true
    if is_ok?(r.plus.to_s + (c+2).to_s)
      if board[r.plus][c+1]==nil
        possible_moves<<r.plus.to_s + (c+2).to_s
        r = r.plus
        c+=1
        next
      else
        break if is_occupied_by_friend?(board[r.plus][c+1],color)
        if is_occupied_by_enemy?(board[r.plus][c+1],color)
          possible_moves<<r.plus.to_s + (c+2).to_s
          break
        end
      end
    else
      break
    end
  end
  r = adress[0].to_sym
  c = adress[1].to_i
  c-=1
  while true
    if is_ok?(r.minus.to_s + (c+2).to_s)
      if board[r.minus][c+1]==nil
        possible_moves<<r.minus.to_s + (c+2).to_s
        r = r.minus
        c+=1
        next
      else
        break if is_occupied_by_friend?(board[r.minus][c+1],color)
        if is_occupied_by_enemy?(board[r.minus][c+1],color)
          possible_moves<<r.minus.to_s + (c+2).to_s
          break
        end
      end
    else
      break
    end
  end
  r = adress[0].to_sym
  c = adress[1].to_i
  c-=1
  while true
    if is_ok?(r.plus.to_s + (c).to_s)
      if board[r.plus][c-1]==nil
        possible_moves<<r.plus.to_s + (c).to_s
        r = r.plus
        c-=1
        next
      else
        break if is_occupied_by_friend?(board[r.plus][c-1],color)
        if is_occupied_by_enemy?(board[r.plus][c-1],color)
          possible_moves<<r.plus.to_s + (c).to_s
          break
        end
      end
    else
      break
    end
  end
  r = adress[0].to_sym
  c = adress[1].to_i
  c-=1
  while true
    if is_ok?(r.minus.to_s + (c).to_s)
      if board[r.minus][c-1]==nil
        possible_moves<<r.minus.to_s + (c).to_s
        r = r.minus
        c-=1
        next
      else
        break if is_occupied_by_friend?(board[r.minus][c-1],color)
        if is_occupied_by_enemy?(board[r.minus][c-1],color)
          possible_moves<<r.minus.to_s + (c).to_s
          break
        end
      end
    else
      break
    end
  end

  return possible_moves
end

def queen adress, board
  helper1 = rook adress,board
  helper2= bishop adress,board
  return helper1+helper2
end

def king_basic adress,board
  r = adress[0].to_sym
  c = adress[1].to_i
  c -= 1
  possible_moves = []
  helper = piece board[r][c]
  color = helper[1]
  if is_ok?(r.to_s + (c+2).to_s) && !is_occupied_by_friend?(board[r][c+1],color)
    possible_moves<<r.to_s + (c+2).to_s
  end
  if is_ok?(r.to_s + (c).to_s) && !is_occupied_by_friend?(board[r][c-1],color)
    possible_moves<<r.to_s + (c).to_s
  end
  r = r.plus
  if is_ok?(r.to_s + (c+1).to_s) && !is_occupied_by_friend?(board[r][c],color)
    possible_moves<<r.to_s + (c+1).to_s
  end
  if is_ok?(r.to_s + (c+2).to_s) && !is_occupied_by_friend?(board[r][c+1],color)
    possible_moves<<r.to_s + (c+2).to_s
  end
  if is_ok?(r.to_s + (c).to_s) && !is_occupied_by_friend?(board[r][c-1],color)
    possible_moves<<r.to_s + (c).to_s
  end
  r = r.minus.minus
  if is_ok?(r.to_s + (c+1).to_s) && !is_occupied_by_friend?(board[r][c],color)
    possible_moves<<r.to_s + (c+1).to_s
  end
  if is_ok?(r.to_s + (c+2).to_s) && !is_occupied_by_friend?(board[r][c+1],color)
    possible_moves<<r.to_s + (c+2).to_s
  end
  if is_ok?(r.to_s + (c).to_s) && !is_occupied_by_friend?(board[r][c-1],color)
    possible_moves<<r.to_s + (c).to_s
  end
  return possible_moves
end

def is_legal? from,to,board
  r = from[0].to_sym
  c = from[1].to_i
  c-=1

  figurine = piece board[r][c]

  options = pawn(from,board) if figurine[0] == "pawn"
  options = knight(from,board) if figurine[0] == "knight"
  options = rook(from,board) if figurine[0] == "rook"
  options = bishop(from,board) if figurine[0] == "bishop"
  options = queen(from,board) if figurine[0] == "queen"
  options = king_basic(from,board) if figurine[0] == "king"
  return true if options.include?(to)
  return false
end
