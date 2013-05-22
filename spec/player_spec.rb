#player_spec.rb

require_relative "../src/player.rb"

describe Player do

  before (:each) do
    @player = Player.new("X", "Human")
  end

  it "should have a piece" do
  	@player.get_piece.should eq("X")
  end

  it "should have a player type" do
  	@player.get_player_type.should eq("Human")
  end

  it "should be able to play a piece" do

  end
end