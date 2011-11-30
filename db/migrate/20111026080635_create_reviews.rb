class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews, :force=>true do |t|
      t.text :review, :null=>false
      t.integer :rating, :null=>false
      t.timestamp :timestamp, :null => false
    end
  end
end
