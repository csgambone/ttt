#player.rb

class Player
  def initialize(piece, player_type)
  	@piece = piece
  	@player_type = player_type
  end

  def get_piece
  	return @piece
  end

  def get_player_type
  	return @player_type
  end

  def get_move(cells)
    if (@player_type == "Human")
      move = human_move
    elsif (@player_type == "Noob")
      move = ai_move
    else (@player_type == "Pro")
      move = ai_pro_move(@piece, cells)
    end
  end

  def human_move
    move = "" 
    until (move =~ /^[0-8]$/)
      move = gets.chomp
    end
    move = move.to_i
  end

  def ai_move
    Random.new.rand(0..8)
  end

  def ai_pro_move(piece, cells)
    if (cells[4] == " ")
      4
    else
      2 
    end
  end

end

# pro ai:
# cycle 8 win conditions, if find 2/3 taken in any, take 3rd to win.
# else cycle each cell, find number of win conditions with one token and current cell for each cell, take cell with highest result
# else take middle, else take random corner, else take random available