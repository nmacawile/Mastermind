require './game'
require './player'
include Mastermind
system("clear")
puts "Game modes: "
puts "   CC, CP, PC or PP"
puts "   P - Player"
puts "   C - Computer"
puts
puts "   First letter is the code setter, the second one is the code breaker."
puts "   e.g. CP"
puts "   Computer(C) makes the code, player(P) tries to break it."
puts "   default game mode: CP"
puts
print "game mode: "
input = gets.chomp.upcase

case input
when 'CC'
	game = Game.new(ComputerPlayer, ComputerPlayer)
when 'PC'
	game = Game.new(HumanPlayer, ComputerPlayer)
when 'PP'
	game = Game.new(HumanPlayer, HumanPlayer)
else
	game = Game.new(ComputerPlayer, HumanPlayer)
end

game.play unless game.nil?