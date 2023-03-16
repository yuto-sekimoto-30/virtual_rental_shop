class CreateTmdbReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :tmdb_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :tmdb_id, null: false
      t.float :rate, null: false, default: 0
      t.string :title
      t.string :comment
      t.references :movie_state_name, null: false, foreign_key: true
      t.date :end_date

      t.timestamps
    end
  end
end
