class AddWorkloadToUsers < ActiveRecord::Migration
  def change
    add_column :users, :workload, :float, :default => 1
  end
end
