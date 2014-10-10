Sequel.migration do
  change do
    alter_table :episodes do
      add_index :season_number
    end
  end
end
