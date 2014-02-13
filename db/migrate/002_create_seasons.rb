Sequel.migration do
  change do
    create_table :seasons do
      primary_key :id
      Integer :number

      foreign_key :show_id, :shows, null: false
    end
  end
end
