require_relative "../src/game.rb"
require_relative "../src/player.rb"

player1 = Player.new("X", "Human")
player2 = Player.new("O", "Pro")

a = Game.new(player1, player2, 3)

a.run