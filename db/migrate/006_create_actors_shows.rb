Sequel.migration do
  change do
    create_table :actors_shows do
      primary_key :id
      foreign_key :actor_id, :actors, on_delete: :cascade, null: false
      foreign_key :show_id,  :shows,  on_delete: :cascade, null: false
      unique [:actor_id, :show_id]
    end
  end
end
