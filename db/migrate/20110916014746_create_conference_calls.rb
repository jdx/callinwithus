class CreateConferenceCalls < ActiveRecord::Migration
  def change
    create_table :conference_calls do |t|
      t.string :code, :unique => true

      t.timestamps
    end
  end
end
