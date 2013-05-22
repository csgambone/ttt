#game.rb
require_relative "../src/board.rb"

class Game
  def initialize(player1, player2)
  	@cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  	@player1 = player1
  	@player2 = player2
    @winner = nil
  end

  def get_cell(location)
  	return @cells[location]
  end

  def set_cell(location, piece)
    @cells[location] = piece
  end

  def turn(player)
    valid_move_flag = 0
    puts "Choose a space to play your piece [0-8]:"

    while (valid_move_flag == 0)
  	  move = player.get_move
      if (@cells[move] == " ")
  	    set_cell(move, player.get_piece)
        valid_move_flag = 1
      else (@cells[move] == @player1.get_piece || @cells[move] == @player2.get_piece)
        puts "That space is occupied, choose again [0-8]:"
      end
    end
  end


  def run
    @board = Board.new(3)
    current_player = @player1
    while (@winner == nil)
      @board.draw_board(@cells)
      if (current_player == @player1)
        turn(@player1)
        current_player = @player2
      else
        turn(@player2)
        current_player = @player1
      end
    end
  end

end
