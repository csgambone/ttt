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
  def get_move
    move = "" 
    until (move =~ /^[0-8]$/)
      move = gets.chomp
    end
    move = move.to_i
    return move
  end
end