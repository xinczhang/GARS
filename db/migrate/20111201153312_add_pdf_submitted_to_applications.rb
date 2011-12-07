class AddPdfSubmittedToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :pdf_submitted, :integer, :default => 0
  end
end
