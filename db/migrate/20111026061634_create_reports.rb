class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
	t.string :filename, :limit=>20, :null=>false
	t.integer :status, :null=>false
	t.text :errorMsg, :null=>false
	t.timestamps
    end
  end
end
