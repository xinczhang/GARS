class ApplicationReview < ActiveRecord::Base
	belongs_to :user
	belongs_to :application
	belongs_to :review
end
