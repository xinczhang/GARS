class Application < ActiveRecord::Base
	belongs_to :apply_yourself
	belongs_to :official_test_score
	has_many :application_reviews
	has_many :users,  :through => :application_reviews
	has_many :reviews,:through => :application_reviews

	validate :apply_yourself_or_official_test_score_existence	

	#helper method for check if at least apply yourself or official score file upload successfully
	def apply_yourself_or_official_test_score_existence
		if (apply_yourself.nil? && official_test_score.nil?)
			errors.add(:apply_yourself, "At least one of apply yourself and official test score should be given to create an applicatoin profile!")
			errors.add(:official_test_score, "At least one of apply yourself and official test score should be given to create an applicatoin profile!")
		end
	end

end
