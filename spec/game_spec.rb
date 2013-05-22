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
end