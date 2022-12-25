class TmdbBookmark < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: { scope: :tmdb_id }
end
