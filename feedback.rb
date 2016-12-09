module Mastermind
	module Feedback
		def evaluate(code, guess)
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
end