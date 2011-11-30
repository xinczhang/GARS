class ResearchArea < ActiveRecord::Base
	set_primary_key :code
	has_and_belongs_to_many :users
end
