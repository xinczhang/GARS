class AddAssignedToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :assigned, :integer, :default => 0
  end
end
