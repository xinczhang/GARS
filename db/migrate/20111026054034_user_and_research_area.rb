class UserAndResearchArea < ActiveRecord::Migration
	def self.up
		create_table :research_areas_users, :id=>false, :force=>true do |t|
			t.references :user
			t.string :research_area_id,:limit=>10,:null=>false
		end
	end

	def self.down
		drop_table :research_areas_users
	end
end
