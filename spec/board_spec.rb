#board_spec.rb

require_relative "../src/board.rb"

describe Board do

  before (:each) do
    @board = Board.new(3)
  end

  it "should draw a blank board" do
    @game.stub(:cells).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @board.draw_board(@game.cells)
  end
end
