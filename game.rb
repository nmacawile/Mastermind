require './helper'
require './feedback'

module Mastermind
	class Game
		include Mastermind::Feedback

		private
		
		attr_accessor :code
		
		public
		
		attr_accessor :codesetter, :codebreaker, :guesses
		
		def initialize(codesetter_class, codebreaker_class)
			@codesetter = codesetter_class.new(self)
			@codebreaker = codebreaker_class.new(self)
			@code = []
			@guesses = {}.compare_by_identity
		end
		
		def play
			create_code
			loop do
				crack_attempt
				print_guesses_with_feedbacks
				break if code_cracked? || out_of_turns?
			end
		end
		
		def	create_code
			self.code = codesetter.set_code
		end
		
		def crack_attempt
			guess = codebreaker.crack_code
			guesses[guess] = evaluate(code, guess)			
		end
		
		def print_guesses_with_feedbacks
			puts
			guesses.each_with_index do |(guess, feedback), turn| 
				puts "#{turn+1}: #{guess.join} #{feedback.join}"	
			end
		end
		
		def code_cracked?
			if guesses.values.last == [4, 0]
				puts "Congratulations! You cracked the code in #{guesses.size} turn(s)."
				true
			else
				false
			end
		end
		
		def out_of_turns?
			if guesses.size >= 12
				puts "Game over! The code is '#{code.join}.'"
				true
			else
				false
			end
		end
		
	end
end