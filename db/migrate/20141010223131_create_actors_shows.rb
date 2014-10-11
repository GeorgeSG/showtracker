class CreateActorsShows < ActiveRecord::Migration
  def change
    create_table :actors_shows, :id => false do |t|
      t.references :actor
      t.references :show
    end

    add_index :actors_shows, [:actor_id, :show_id], unique: true
  end

  def self.down
    drop_table :actors_shows
  end
end
