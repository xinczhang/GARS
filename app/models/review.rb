class Review < ActiveRecord::Base
	has_one :application_review
	has_one :user, :through => :application_review
	has_one :application, :through => :application_review
end
