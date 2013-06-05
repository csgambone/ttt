#player.rb

WIN_COND = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
SIDE = [1,3,5,7]
CORNER = [0,2,6,8]
MIDDLE = [4]

class Player
  def initialize(piece, player_type)
  	@piece = piece
  	@player_type = player_type
    @piece == "X" ? @enemy_piece = "O" : @enemy_piece = "X"
  end

  attr_accessor :piece, :player_type, :enemy_piece

  def get_move(cells)
    if (@player_type == "Human")
      move = human_move
    elsif (@player_type == "Noob")
      move = ai_noob_move
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

  def ai_noob_move
    Random.new.rand(0..8)
  end

  def win_or_block_win(piece, cells)
    WIN_COND.each do |cond|
      if ([cells[cond[0]], cells[cond[1]], cells[cond[2]]].sort == [piece, piece, " "].sort)
        cond.each do |cond_element|
          return cond_element if cells[cond_element] == " "
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
            if ([cells[cond[1]], cells[cond[2]]].sort == [other_piece, " "].sort)
              priority[i] += 1
            end
          end

          if i == cond[1]
            if ([cells[cond[0]], cells[cond[2]]].sort == [other_piece, " "].sort)
              priority[i] += 1
            end
          end

          if i == cond[2]
            if ([cells[cond[0]], cells[cond[1]]].sort == [other_piece, " "].sort)
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
      elsif (priority[i] != 0) && (priority[i] == value)
        if ((SIDE.include?(move) && (CORNER.include?(i) || MIDDLE.include?(i))) || (CORNER.include?(move) && MIDDLE.include?(i)))
          move = i
        end
      end
    end
    return move
  end

  def take_cell_type(type, cells)
    type.each do |cell|
      if cells[cell] == " "
        return cell
      end
    end
    return nil
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

    #two corners trick block
    if (cells[4] == @piece && ([cells[0], cells[8]] == [@enemy_piece, @enemy_piece] || [cells[2], cells[6]] == [@enemy_piece, @enemy_piece]))
      if take_cell_type(SIDE, cells) != nil
        return take_cell_type(SIDE, cells)
      end
    end

    #block enemy best play
    if take_or_block_most_advantageous_spot(@piece, @enemy_piece, cells) != nil
      return take_or_block_most_advantageous_spot(@piece, @enemy_piece, cells)
    end

    #take own best play
    if take_or_block_most_advantageous_spot(@enemy_piece, @piece, cells) != nil
      return take_or_block_most_advantageous_spot(@enemy_piece, @piece, cells)
    end

    #take middle
    if take_cell_type(MIDDLE, cells) != nil
      return take_cell_type(MIDDLE, cells)
    end

    #take a corner
    if take_cell_type(CORNER, cells) != nil
      return take_cell_type(CORNER, cells)
    end

    #take a side
    if take_cell_type(SIDE, cells) != nil
      return take_cell_type(SIDE, cells)
    end
  end
end