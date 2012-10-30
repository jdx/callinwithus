class AddIndex < ActiveRecord::Migration
  def up
    add_index :conference_calls, :created_at
  end

  def down
  end
end
