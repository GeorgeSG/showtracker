Sequel.migration do
  change do
    create_table :actors do
      primary_key :id
      String :name, null: false
      String :photo
    end
  end
end
