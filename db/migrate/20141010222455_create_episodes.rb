class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :api_id, null: false
      t.string :combined_episode_number
      t.string :combined_season
      t.string :director
      t.string :name, null: false
      t.integer :episode_number
      t.string :first_aired
      t.string :imdb_id
      t.string :language
      t.string :overview, :text
      t.float :rating
      t.integer :rating_count
      t.integer :season_number
      t.string :writer
      t.integer :airs_before_episode
      t.integer :airs_before_season
      t.string :photo
      t.string :last_updated
      t.integer :season_api_id
      t.integer :series_api_id
      t.string :thumb_added
      t.integer :thumb_height
      t.integer :thumb_width

      t.references :show, index: true

      t.timestamps
    end
  end
end
