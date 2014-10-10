Sequel.migration do
  up do
    alter_table :shows do
      drop_column :network
      add_foreign_key :network_id, :networks, on_delete: :set_null
    end
  end

  down do
    alter_table :shows do
      drop_column :network_id
      add_column :network, String
    end
  end
end
