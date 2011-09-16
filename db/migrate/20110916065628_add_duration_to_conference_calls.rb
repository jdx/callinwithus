class AddDurationToConferenceCalls < ActiveRecord::Migration
  def change
    change_table :conference_calls do |t|
      t.integer :duration
    end
  end
end
