class CreateApplicationReviews < ActiveRecord::Migration
  def change
    create_table :application_reviews, :id=>false, :force=>true do |t|
	t.references :application
	t.references :review
	t.references :user
    end
  end
end
