class WordUpdateAddColors < ActiveRecord::Migration
  def up
    add_column :words, :colors, :text
  end

  def down
  end
end
