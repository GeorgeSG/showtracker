Sequel.migration do
  change do
    create_table :usershows do
      primary_key :id
      Integer :episode
      Integer :season

      foreign_key :show_id, :shows, on_delete: :cascade, null: false
      foreign_key :user_id, :users, on_delete: :cascade, null: false

      unique [:show_id, :user_id]
    end
  end
end
