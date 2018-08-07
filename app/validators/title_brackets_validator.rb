class TitleBracketsValidator < ActiveModel::Validator
	# Changed brackets from variables to constants

	OPENING_BRACKETS = ['(', '[', '{']
	CLOSING_BRACKETS = [')', ']', '}']

  def validate(record)
		@expected = [] #stack needed to keep order of brackets
		@just_opened = false #needed to check if bracket is empty
		record.title.each_char do |c|
			if (id = opening_bracket?(c))
				open_bracket(id)
			elsif (id = closing_bracket?(c))
				record.errors.add(:title, 'unmatched closing bracket') unless close_bracket?(id)
				record.errors.add(:title, 'empty bracket') if @just_opened
			else
				@just_opened = false
			end
		end
		record.errors.add(:title, 'unmatched opening bracket') unless @expected.empty?
	end

	private
	def opening_bracket?(char)
		#checks if char is in OPENING_BRACKETS and returns its position if it is not returns nil
		OPENING_BRACKETS.index(char)
	end

	def closing_bracket?(char)
		CLOSING_BRACKETS.index(char)
	end

	def open_bracket(bracket_id)
		@expected << CLOSING_BRACKETS[bracket_id]
		@just_opened = true
	end
	
	def close_bracket?(bracket_id)
		@expected.pop == CLOSING_BRACKETS[bracket_id]
	end
end
