Sequel.migration do
  up do
    alter_table :shows do
      set_column_default :rating, 0
      set_column_default :rating_count, 0
    end
  end

  down do
    alter_table :shows do
      set_column_default :rating, nil
      set_column_default :rating_count, nil
    end
  end
end
