#game_spec.rb

require_relative "../src/game.rb"
require_relative "../src/player.rb"

describe Game do

  before (:each) do
  	@player1 = Player.new("X", "Human")
  	@player2 = Player.new("O", "Human")
    @game = Game.new(@player1, @player2)
  end

  it "should set bottom left to player2's piece" do
    @game.set_cell(6, @player2.get_piece)
    expect(@game.get_cell(6)).to eq(@player2.get_piece)
  end

  it "should return nil" do
  	@game.win_check(@game.get_cells, @player1).should eq(nil)
  end

  it "should have player 1 win" do
  	@game.set_cell(0, "X")
  	@game.set_cell(1, "X")
  	@game.set_cell(2, "X")

  	@game.win_check(@game.get_cells, @player1).should eq(@player1)
  end

  it "should have player 2 win" do
  	@game.set_cell(0, "O")
  	@game.set_cell(4, "O")
  	@game.set_cell(8, "O")

  	@game.win_check(@game.get_cells, @player2).should eq(@player2)
  end
end