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
	attr_accessor :codes

	def initialize(game)
		super
		@codes ||= ('A'..'H').to_a.repeated_permutation(4).to_a
	end

	def set_code
		my_code = Array.new(4) { ('A'..'H').to_a.sample }
		puts "cough #{my_code.join} cough"
		my_code
	end	
	
	def first_guesses
		@first_guesses ||= [%w(A A B B), %w(C C D D), %w(E E F F), %w(G G H H)]
	end

	def eliminate_bad_codes
		last_guess = game.guesses.keys.last
		last_feedback = game.guesses.values.last
		codes.delete_if do |code|
			feedback(code, last_guess) != last_feedback
		end
	end
	
	def crack_code
		eliminate_bad_codes unless game.guesses.empty?
		unless first_guesses.empty?
			first_guesses.shift
		else
			codes[0]
		end
		
	end
	
	def feedback(code, guess)
		code_copy = code.clone
		indices = []
		
		indirect_match = 0
		direct_match = 0
		
		guess.each_with_index do |char, index|
			if code[index] == char
				direct_match += 1
				code_copy[index] = nil
			else
				indices << index
			end
		end
		
		guess.values_at(*indices).each do |char|
			if code_copy.include?(char)
				indirect_match += 1
				code_copy.update_first_match!(char) { nil }
			end
		end

		[direct_match, indirect_match]
	end

end