Sequel.migration do
  change do
    create_table :shows_genres do
      primary_key :id
      foreign_key :show_id,  :shows,  on_delete: :cascade, null: false
      foreign_key :genre_id, :genres, on_delete: :cascade, null: false

      unique [:show_id, :genre_id]
    end

  end
end
