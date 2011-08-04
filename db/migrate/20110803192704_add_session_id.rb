class AddSessionId < ActiveRecord::Migration
  def up
    add_column :words, :session_id, :string
  end

  def down
  end
end
