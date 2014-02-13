Sequel.migration do
  change do
    create_table :episodes do
      primary_key :id
      String :name,       null: false
      String :descrition, text: true

      foreign_key :season_id, :seasons, null: false
    end
  end
end
