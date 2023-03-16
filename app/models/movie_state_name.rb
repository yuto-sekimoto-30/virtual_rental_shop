class MovieStateName < ApplicationRecord
  has_many :movie_states, dependent: :destroy
  has_many :tmdb_reviews, dependent: :destroy
end
