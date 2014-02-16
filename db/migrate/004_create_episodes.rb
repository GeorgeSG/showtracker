Sequel.migration do
  change do
    create_table :episodes do
      primary_key :id
      String :api_id, null: false
      String :combined_episode_number
      String :combined_season
      String :director
      String :name,       null: false
      Integer :episode_number
      String :first_aired
      String :imdb_id
      String :language
      String :overview, text: true
      Float :rating
      Integer :rating_count
      Integer :season_number
      String :writer
      Integer :airs_before_episode
      Integer :airs_before_season
      String :photo
      String :last_updated
      Integer :season_api_id
      Integer :series_api_id
      String :thumb_added
      Integer :thumb_height
      Integer :thumb_width

      foreign_key :show_id, :shows, on_delete: :cascade
    end
  end
end
