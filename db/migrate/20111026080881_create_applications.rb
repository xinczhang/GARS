class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications,:force=>true do |t|
      t.references :apply_yourself
      t.references :official_test_score
      t.timestamps
    end
  end
end
