require './game'
require './player'
include Mastermind

#game = Game.new(ComputerPlayer, HumanPlayer)
#game = Game.new(HumanPlayer, HumanPlayer)
#game = Game.new(HumanPlayer, ComputerPlayer)
game = Game.new(ComputerPlayer, ComputerPlayer)

game.play

#gets.chomp