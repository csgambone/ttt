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
end