class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name, null: false
      t.string :api_id
      t.string :airs_day
      t.string :airs_time
      t.string :content_rating
      t.string :first_aired
      t.string :imdb_id
      t.string :language
      t.string :network
      t.string :overview, :text
      t.float  :rating, default: 0
      t.integer :rating_count, default: 0
      t.integer :running_time
      t.string :status
      t.string :added
      t.string :added_by
      t.string :banner
      t.string :fanart
      t.string :last_updated
      t.string :poster

      t.references :network, index: true

      t.timestamps
    end
  end
end
