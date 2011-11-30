class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users,:force=>true do |t|
      t.string  :name,:limit=>20,:null=>false
      t.string  :email,:null=>false
      t.string  :password,:null=>false
      t.integer :sex,:null=>false
      t.integer :role,:null=>false
      t.timestamps
    end
  end
end
