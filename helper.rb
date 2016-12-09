module Enumerable
	def update_first_match!(value)
		index = self.find_index(value)
		self[index] = yield(self[index]) unless index.nil?
	end
end