class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :season, default: 0
      t.integer :episode, default: 0

      t.references :user, index: true
      t.references :show, index: true

      t.timestamps
    end

    add_index :subscriptions, [:user_id, :show_id], :unique => true
  end
end
