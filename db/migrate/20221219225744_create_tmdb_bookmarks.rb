class CreateTmdbBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :tmdb_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :tmdb_id, null: false

      t.timestamps
    end
  end
end
