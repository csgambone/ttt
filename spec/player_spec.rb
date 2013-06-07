#player_spec.rb

require_relative "../src/player.rb"

describe Player do

  it "O should have an enemy piece" do
    @player = Player.new("O", "Pro")
    @player.enemy_piece.should eq("X")
  end

  it "X should have an enemy piece" do
    @player = Player.new("X", "Human")
    @player.enemy_piece.should eq("O")
  end

  it "should have a piece" do
    @player = Player.new("X", "Human")
  	@player.piece.should eq("X")
  end

  it "should have a player type" do
    @player = Player.new("X", "Human")
  	@player.player_type.should eq("Human")
  end


  it "should get valid move from human" do
    @player = Player.new("X", "Human")
    @game.stub(:cells).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @player.stub(:gets).and_return('8')
    @player.get_move(@game.cells).should eq(8)
  end

  it "should get a valid move from noob" do
    cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    valid = [0,1,2,3,4,5,6,7,8]
    @player = Player.new("O", "Noob")
    valid.should include(@player.ai_noob_move)
  end


  @tests = {[" ", " ", " ", " ", " ", " ", " ", " ", " "] => 4,
            ["X", " ", " ", " ", " ", " ", " ", " ", " "] => 4,
            [" ", " ", " ", " ", " ", " ", " ", " ", "X"] => 4,
            ["O", " ", "O", " ", "X", " ", " ", " ", " "] => 1,
            ["X", " ", " ", " ", "O", " ", " ", " ", "X"] => 1,
            [" ", " ", "X", " ", "O", " ", "X", " ", " "] => 1,
            ["X", "O", "X", " ", "O", "O", "O", "X", "X"] => 3,
            ["X", "X", "O", "O", "O", " ", "X", "X", " "] => 5,
            [" ", " ", "X", " ", "O", "X", " ", " ", " "] => 8,
            [" ", "X", "X", " ", "O", "X", " ", " ", " "] => 0,
            [" ", " ", " ", " ", "O", " ", "X", " ", "X"] => 7}
  @tests.each do |cells, move|
    it "returns move:#{move} when input cells are:#{cells}" do
      @player = Player.new("O", "Pro")
      @player.ai_pro_move(cells).should eq(move)
    end
  end
end