class Team < ApplicationRecord
	has_many :results
	has_many :drivers, foreign_key: 'current_team'
end
