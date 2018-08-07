class TitleBracketsValidator < ActiveModel::Validator
	# Changed brackets from variables to constants

	OPENING_BRACKETS = ['(', '[', '{']
	CLOSING_BRACKETS = [')', ']', '}']

  def validate(record)
		expected = []
		just_opened = false #Needed to check if opened bracket is empty
		record.title.each_char do |c|
			if !(id = OPENING_BRACKETS.index(c)).nil?
				expected << CLOSING_BRACKETS[id]
				just_opened = true
				next
			elsif !(id = CLOSING_BRACKETS.index(c)).nil?
				record.errors.add(:title, 'unmatched closing bracket') if expected.pop != CLOSING_BRACKETS[id]
				record.errors.add(:title, 'empty bracket') if just_opened
			else
				just_opened = false
			end
		end
		record.errors.add(:title, 'unmatched opening bracket') if !expected.empty?
	end
end
