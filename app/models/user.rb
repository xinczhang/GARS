class User < ActiveRecord::Base
	has_and_belongs_to_many :research_areas
	has_many :application_reviews
	has_many :reviews, :through => :application_reviews
	has_many :applications, :through => :application_reviews
end
