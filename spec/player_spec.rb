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
    @game.stub(:cells).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @player.stub(:gets).and_return('8')
    @player.get_move(@game.cells).should eq(8)
  end

  @player = Player.new("O", "Pro")

  @tests = {[" ", " ", " ", " ", " ", " ", " ", " ", " "] => 4,
            ["X", " ", " ", " ", " ", " ", " ", " ", " "] => 4,
            [" ", " ", " ", " ", " ", " ", " ", " ", "X"] => 4,
            ["O", " ", "O", " ", "X", " ", " ", " ", " "] => 1,
            ["X", " ", " ", " ", "O", " ", " ", " ", "X"] => 1,
            ["X", "O", "X", " ", "O", "O", "O", "X", "X"] => 3,
            ["X", "X", "O", "O", "O", " ", "X", "X", " "] => 5,
            [" ", " ", " ", " ", "O", " ", "X", " ", "X"] => 7}
  @tests.each do |cells, move|
    it "returns move:#{move} when input cells are:#{cells}" do
      @player.ai_pro_move(cells).should eq(move)
    end
  end
end