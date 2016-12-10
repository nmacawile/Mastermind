require './helper'
require './feedback'

module Mastermind
	class Game
		include Mastermind::Feedback

		private
		
		attr_accessor :code
		
		public
		
		attr_accessor :codesetter, :codebreaker, :guesses, :code_size, :possible_code_chars_size
		
		def initialize(codesetter_class, codebreaker_class)
			@codesetter = codesetter_class.new(self)
			@codebreaker = codebreaker_class.new(self)
			@code = []
			@guesses = {}.compare_by_identity 
		end
		
		def play
			create_code	
			print_guidelines
			loop do
				crack_attempt				
				print_guesses_with_feedbacks
				break if code_cracked? || out_of_turns?
			end
		end

		def print_guidelines
			system("clear")					
			puts "   The code has been set."
			puts "   Find the 4-letter secret code."
			puts
			puts "   You will be given a 2-digit feedback based on the quality of your guess."
			puts "   The first digit represents the number of characters that directly" 
			puts "   match the secret code."
			puts "   The second digit represents the number of characters that are found"
			puts "   in the secret code but are not in the right position."
		end
		
		def	create_code
			self.code = codesetter.set_code
			system("clear")
		end
		
		def crack_attempt
			guess = codebreaker.crack_code
			guesses[guess] = evaluate(code, guess)			
		end
		
		def print_guesses_with_feedbacks
			system("clear")	
			guesses.each_with_index do |(guess, feedback), turn| 
				puts "#{turn+1}: #{guess.join} #{feedback.join}"	
			end
		end
		
		def code_cracked?
			if guesses.values.last == [4, 0]
				puts "#{codebreaker} cracked the code in #{'turn'.pluralize('turns', guesses.size)}!"
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