module Enumerable
	def update_first_match!(value)
		index = self.find_index(value)
		self[index] = yield(self[index]) unless index.nil?
	end
end

class String
	def pluralize(plural_form, count)
		if count == 1
			"1 #{self}"
		else
			"#{count} #{plural_form}"
		end
	end
end