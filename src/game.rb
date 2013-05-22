#game.rb

class Game
  def initialize(player1, player2)
  	@cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  	@player1 = player1
  	@player2 = player2
  end

  def get_cell(location)
  	return @cells[location]
  end

  def set_cell(location, piece)
    @cells[location] = piece
  end

  def turn(player)
  	move = player.get_move
  	set_cell(move, player.get_piece)
  end

end
