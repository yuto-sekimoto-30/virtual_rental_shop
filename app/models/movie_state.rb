class MovieState < ApplicationRecord
  belongs_to :user
  belongs_to :movie_state_name
  validates :user_id, uniqueness: { scope: :tmdb_id }
end
