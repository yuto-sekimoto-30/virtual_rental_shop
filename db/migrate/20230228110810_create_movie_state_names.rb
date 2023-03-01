class CreateMovieStateNames < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_state_names do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
