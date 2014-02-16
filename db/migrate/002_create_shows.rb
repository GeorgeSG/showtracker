Sequel.migration do
  change do
    create_table :shows do
      primary_key :id
      String :name, null: false

      String :api_id
      String :airs_day
      String :airs_time
      String :content_rating
      String :first_aired
      String :imdb_id
      String :language
      String :network
      String :overview, text: true
      Float  :rating
      Integer :rating_count
      Integer :running_time
      String :status
      String :added
      String :added_by
      String :banner
      String :fanart
      String :last_updated
      String :poster
    end
  end
end
