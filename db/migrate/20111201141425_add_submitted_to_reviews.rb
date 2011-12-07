class AddSubmittedToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :submitted, :integer, :default => 0
  end
end
