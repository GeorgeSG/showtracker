Sequel.migration do
  up do
    alter_table :usershows do
      set_column_default :episode, 0
      set_column_default :season, 0
    end
  end

  down do
    alter_table :usershows do
      set_column_default :episode, nil
      set_column_default :season, nil
    end
  end
end
