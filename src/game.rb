#game.rb
require_relative "../src/board.rb"

WIN_COND = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

class Game
  def initialize(player1, player2, size)
  	@cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @size = size
  	@player1 = player1
  	@player2 = player2
    @winner = nil
  end

  def get_cell(location)
  	return @cells[location]
  end

  def get_cells
    return @cells
  end

  def set_cell(location, piece)
    @cells[location] = piece
  end

  def turn(player)
    valid_move_flag = 0
    if player.player_type == "Human"
      puts "Choose a space to play your piece [0-8]:"
    end

    while (valid_move_flag == 0)
  	  move = player.get_move(@cells)
      if (@cells[move] == " ")
  	    set_cell(move, player.piece)
        valid_move_flag = 1
      else (@cells[move] == @player1.piece || @cells[move] == @player2.piece)
        if player.player_type == "Human"
          puts "That space is occupied, choose again [0-8]:"
        end
      end
    end
  end

  def win_check(cells, player)
    result = nil
    WIN_COND.each do |cond|
      if [cells[cond[0]], cells[cond[1]], cells[cond[2]]] == [player.piece, player.piece, player.piece]
        result = player
      end
    end
    return result
  end


  def run
    @board = Board.new(@size)
    turn = 0
    current_player = @player1

    while (@winner == nil && turn < @size*@size)
      puts "TURN: #{turn}"
      @board.draw_board(@cells)
      if (current_player == @player1)
        turn(@player1)
        @winner = win_check(@cells, @player1)
        current_player = @player2
        turn += 1
      else
        turn(@player2)
        @winner = win_check(@cells, @player2)
        current_player = @player1
        turn += 1
      end
    end
    
    puts "TURN: #{turn}"
    @board.draw_board(@cells)
    if @winner
      puts "The winner is #{@winner.piece}!"
    else
      puts "The game is a tie!"
    end
  end

end
