class Result < ApplicationRecord
	belongs_to :driver
	belongs_to :race
	belongs_to :team
	belongs_to :engine, optional: true

end
