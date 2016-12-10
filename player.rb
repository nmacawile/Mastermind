require './feedback'
class Player
	attr_accessor :game
	
	def initialize(game)
		@game = game
	end
end

class HumanPlayer < Player
	def set_code
		show_code_guidelines
		keyboard_input
	end
	
	def crack_code
		keyboard_input
	end 
	
	def keyboard_input
		my_code = nil
		loop do
			print "Input code: "
			input = gets.chomp.upcase.scan(/[A-H]/)
			my_code = input[0..3]
			break if my_code.size == 4
			puts "Error! Your input must have atleast 4 characters between A and H."
		end
		
		my_code
	end
	
	def show_code_guidelines
		puts "Create the code."
		puts "Only characters between A and H are accepted."
		puts "Other characters will be ignored automatically."
		puts "Only 4 characters from your input will be accepted."
		puts "Excess characters will be omitted automatically."
	end
end

class ComputerPlayer < Player
	include Mastermind::Feedback

	attr_accessor :codes, :first_guesses, :matched_chars_count

	def initialize(game)
		super
		@codes = ('A'..'H').to_a.repeated_permutation(4).to_a
		@first_guesses = []
		('A'..'H').each_slice(2) { |a, b| @first_guesses << [a, a, b, b] }
		@matched_chars_count = 0
	end

	def set_code
		my_code = Array.new(4) { ('A'..'H').to_a.sample }
		puts "cough #{my_code.join} cough"
		my_code
	end	
	
	def eliminate_bad_codes
		last_guess = game.guesses.keys.last
		last_feedback = game.guesses.values.last
		codes.delete_if do |code|
			evaluate(code, last_guess) != last_feedback
		end
		self.matched_chars_count += last_feedback.reduce(:+)
	end
	
	def crack_code
		eliminate_bad_codes unless game.guesses.empty?
		unless first_guesses.empty?	|| matched_chars_count >= 4		
			first_guesses.shift
		else
			codes[0]
		end
		
	end

end