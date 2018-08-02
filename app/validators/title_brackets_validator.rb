class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
		open = ['(', '[', '{']
		close = [')', ']', '}']
		opened = 0
		just_opened = false
		expected = []
		record.title.each_char do |c|
			id = open.index(c)
			if id != nil
				opened += 1
				expected << id
				just_opened = true
				next
			else
				id = close.index(c)
				if id != nil
					if expected.pop == id
						just_opened ? record.errors.add(:title, 'empty bracket') : opened -= 1
					else
						record.errors.add(:title, 'unmatched closing bracket')
						break
					end
				end
			end
			just_opened = false
		end
		record.errors.add(:title, 'unmatched opening bracket') if opened != 0
  end
end
