class AddProgramToApplications < ActiveRecord::Migration
  def change
	add_column :applications, :program, :string, :default=>"master"
  end
end
