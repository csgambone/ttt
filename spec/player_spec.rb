#player_spec.rb

require_relative "../src/player.rb"

describe Player do

  it "should have an enemy piece" do
    @player = Player.new("O", "Pro")
    @player.enemy_piece.should eq("X")
  end



  before (:each) do
    @player = Player.new("X", "Human")
  end

  it "should have a piece" do
  	@player.piece.should eq("X")
  end

  it "should have a player type" do
  	@player.player_type.should eq("Human")
  end

  it "should have an enemy piece" do
    @player.enemy_piece.should eq("O")
  end

  it "should get valid move" do
    @game.stub(:get_cells).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @player.stub(:gets).and_return('8')
    @player.get_move(@game.get_cells).should eq(8)
  end
end