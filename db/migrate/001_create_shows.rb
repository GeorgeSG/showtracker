Sequel.migration do
  change do
    create_table :shows do
      primary_key :id
      String :name,        null: false
      String :description, text: true
    end
  end
end
