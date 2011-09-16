class CreateConferenceCallers < ActiveRecord::Migration
  def change
    create_table :conference_callers do |t|
      t.string :phone_number
      t.integer :duration
      t.string :country
      t.string :state
      t.string :zip
      t.string :city
      t.integer :conference_call_id

      t.timestamps
    end
  end
end
