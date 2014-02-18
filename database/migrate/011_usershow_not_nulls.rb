Sequel.migration do
  up do
    alter_table :usershows do
      drop_column :episode
      add_column :episode, Integer, default: 0, null: false

      drop_column :season
      add_column :season, Integer, default: 0, null: false
    end
  end

  down do
    alter_table :usershows do
      set_column_allow_null :episode
      set_column_allow_null :season
      set_column_default :episode, nil
      set_column_default :season, nil
    end
  end
end
