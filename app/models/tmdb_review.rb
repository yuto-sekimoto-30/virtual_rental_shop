class TmdbReview < ApplicationRecord
  belongs_to :user
  belongs_to :movie_state_name

  validates :user_id, uniqueness: { scope: :tmdb_id }
  validates :title, presence: true
  validates :comment, presence: true
  validates :title,    length: { maximum: 20 }
  validates :comment,    length: { maximum: 100 }
end
