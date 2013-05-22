#board.rb

class Board
  def initialize(size)
    @size = size
    @horiz_div = ""
    for i in 0..((size*2)-1)
      @horiz_div << "_"
    end
  end

  def draw_board(cells)
    for i in 0..(@size-1)
      for j in 0..(@size-1)
        print "#{cells[(i*@size)+j]}"
        print "|" unless j==@size-1
      end
      print "\n#{@horiz_div}\n" unless i==@size-1
    end 
    print "\n\n"
  end
end
