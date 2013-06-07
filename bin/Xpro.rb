require_relative "../src/game.rb"
require_relative "../src/player.rb"

player1 = Player.new("X", "Pro")
player2 = Player.new("O", "Human")

a = Game.new(player1, player2, 3)

a.run