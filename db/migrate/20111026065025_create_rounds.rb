class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
	t.timestamp :startTime
      	t.timestamp :endTime
    end
  end
end
