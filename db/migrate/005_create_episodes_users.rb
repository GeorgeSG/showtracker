Sequel.migration do
  change do
    create_table :episodes_users do
      primary_key :id
      foreign_key :user_id,    :user,     null: false
      foreign_key :episode_id, :episodes, null: false

      unique [:user_id, :episode_id]
    end

  end
end
