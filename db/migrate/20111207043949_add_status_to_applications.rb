class AddStatusToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :status, :integer, :default => 0
  end
end
