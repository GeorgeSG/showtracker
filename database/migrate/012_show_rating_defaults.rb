Sequel.migration do
  up do
    alter_table :shows do
      drop_column :rating
      add_column :rating, Float, default: 0, null: false

      drop_column :rating_count
      add_column :rating_count, Integer, default: 0, null: false
    end
  end

  down do
    alter_table :shows do
      set_column_allow_null :rating
      set_column_allow_null :rating_count
      set_column_default :rating, nil
      set_column_default :rating_count, nil
    end
  end
end
