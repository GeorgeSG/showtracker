class ChangeOverviewInShows < ActiveRecord::Migration
  def up
    change_column :shows, :overview, :text
  end

  def down
    change_column :shows, :overview, :string
  end
end
