class ChangeNameInEpisodes < ActiveRecord::Migration
  def up
    change_column :episodes, :name, :string, null: true
  end

  def down
    change_column :episodes, :name, :string, null: false
  end
end
