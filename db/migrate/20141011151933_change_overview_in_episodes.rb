class ChangeOverviewInEpisodes < ActiveRecord::Migration
  def up
    change_column :episodes, :overview, :text
  end

  def down
    change_column :episodes, :overview, :string
  end
end
