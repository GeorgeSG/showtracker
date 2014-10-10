Sequel.migration do
  change do
    alter_table :shows do
      add_index :name
      add_index :rating_count
    end
  end
end
