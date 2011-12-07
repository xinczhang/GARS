class AddSubmittedToApplicationReviews < ActiveRecord::Migration
  def change
    add_column :application_reviews, :submitted, :integer, :default => 0
  end
end
