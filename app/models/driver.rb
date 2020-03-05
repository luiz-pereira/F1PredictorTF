class Driver < ApplicationRecord
	has_many :results
	belongs_to :current_team, class_name: "Team", optional: true
end
