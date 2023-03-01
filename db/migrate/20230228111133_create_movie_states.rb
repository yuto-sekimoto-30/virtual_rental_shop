class CreateMovieStates < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_states do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :tmdb_id, null: false
      t.references :movie_state_name, null: false, foreign_key: true

      t.timestamps
    end
  end
end
