require_relative "../src/game.rb"
require_relative "../src/player.rb"

player1 = Player.new("X", "Human")
player2 = Player.new("O", "Noob")

a = Game.new(player1, player2)

a.run