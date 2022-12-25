class CreateTmdbComments < ActiveRecord::Migration[6.1]
  def change
    create_table :tmdb_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :tmdb_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
