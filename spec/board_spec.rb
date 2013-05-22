#board_spec.rb

require_relative "../src/board.rb"

describe Board do

  before (:each) do
    @board = Board.new(3)
  end

  #it "should draw a cell" do
  #  row_index = 0
  #  column_index = 0

  #  @board.stub(:get_cell).and_return("X")
 
  #  @board.draw_cell(row_index, column_index)
  #  @board.get_cell(row_index, column_index).should eq("X") 
  #end

  it "should draw a blank board" do
    @game.stub(:get_cells).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @board.draw_board(@game.get_cells)
  end
end
