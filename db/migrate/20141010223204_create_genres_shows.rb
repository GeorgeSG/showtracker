class CreateGenresShows < ActiveRecord::Migration
  def change
    create_table :genres_shows, :id => false do |t|
      t.references :genre
      t.references :show
    end

    add_index :genres_shows, [:genre_id, :show_id], unique: true
  end

  def self.down
    drop_table :genres_shows
  end
end
