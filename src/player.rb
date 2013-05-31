#player.rb

WIN_COND = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

class Player
  def initialize(piece, player_type)
  	@piece = piece
  	@player_type = player_type
    if @piece == "X"
      @enemy_piece = "O"
    else
      @enemy_piece = "X"
    end
  end

  attr_accessor :piece, :player_type, :enemy_piece

  def get_move(cells)
    if (@player_type == "Human")
      move = human_move
    elsif (@player_type == "Noob")
      move = ai_move
    else (@player_type == "Pro")
      move = ai_pro_move(cells)
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

  def win_or_block_win(piece, cells)
    WIN_COND.each do |cond|
      if ([cells[cond[0]], cells[cond[1]], cells[cond[2]]].join == [piece, piece, " "].join) || ([cells[cond[0]], cells[cond[1]], cells[cond[2]]].join == [piece, " ", piece].join) || ([cells[cond[0]], cells[cond[1]], cells[cond[2]]].join == [" ", piece, piece].join)
        if cells[cond[0]] == " "
          return cond[0]
        elsif cells[cond[1]] == " "
          return cond[1]
        else
          return cond[2]
        end
      end
    end
    return nil
  end

  def take_or_block_most_advantageous_spot(piece, other_piece, cells)
    priority = [0,0,0,0,0,0,0,0,0]
    value = 0
    move = nil

    for i in 0..8
      if cells[i] == " "
        WIN_COND.each do |cond|
          if i == cond[0]
            if cells[cond[1]] == other_piece && cells[cond[2]] != piece
              priority[i] += 1
            elsif cells[cond[2]] == other_piece && cells[cond[1]] != piece
              priority[i] += 1
            end
          end

          if i == cond[1]
            if cells[cond[0]] == other_piece && cells[cond[2]] != piece
              priority[i] += 1
            elsif cells[cond[2]] == other_piece && cells[cond[0]] != piece
              priority[i] += 1
            end
          end

          if i == cond[2]
            if cells[cond[0]] == other_piece && cells[cond[1]] != piece
              priority[i] += 1
            elsif cells[cond[1]] == other_piece && cells[cond[0]] != piece
              priority[i] += 1
            end
          end
        end
      end
    end

    for i in 0..8
      if priority[i] > value
        value = priority[i]
        move = i
      end
      if (priority[i] != 0) && (priority[i] == value)
        if (move == 1 || move == 3 || move == 5 || move == 7) && (i == 0 || i == 2 || i == 6 || i == 8 || i == 4)
          move = i
        elsif (move == 0 || move == 2 || move == 6 || move == 8) && (i == 4)
          move = i
        end
      end
    end

    if move != nil
      return move
    else
      return nil
    end
  end

  def ai_pro_move(cells)
    #take win
    if win_or_block_win(@piece, cells) != nil
      return win_or_block_win(@piece, cells)
    end

    #block enemy win
    if win_or_block_win(@enemy_piece, cells) != nil
      return win_or_block_win(@enemy_piece, cells)
    end

    #block enemy best play
    if take_or_block_most_advantageous_spot(@piece, @enemy_piece, cells) != nil
      return take_or_block_most_advantageous_spot(@piece, @enemy_piece, cells)
    end

    #take own best play
    if take_or_block_most_advantageous_spot(@piece, @enemy_piece, cells) != nil
      return take_or_block_most_advantageous_spot(@enemy_piece, @piece, cells)
    end

    #take middle
    if cells[4] == " "
      return 4
    end

    #take a corner
    [0,2,6,8].each do |corner|
      if cells[corner] == " "
        return corner
      end
    end

    #take a side
    [1,3,5,7].each do |side|
      if cells[side] == " "
        return side
      end
    end
  end
end

# pro ai:
# cycle 8 win conditions, if find 2/3 taken in any, take 3rd to win.
# else cycle each cell, find number of win conditions with one enemy token and current cell for each cell, take cell with highest result
# else cycle each cell, find number of win conditions with one friendly token and current cell for each cell, take cell with highest result
# else take middle, else take random corner, else take random available