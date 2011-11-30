class CreateResearchAreas < ActiveRecord::Migration
  def change
    create_table :research_areas, :id=>false, :force=>true do |t|
	t.string :code, :limit=>10, :null=>false
	t.string :name, :null=>false
    end
    add_index :research_areas, :code, :unique=>true
  end
end
