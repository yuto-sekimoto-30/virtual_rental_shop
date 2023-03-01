class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  has_many :tmdb_bookmarks, dependent: :destroy
  has_many :tmdb_comments, dependent: :destroy
  has_many :movie_states, dependent: :destroy
  has_many :tmdb_reviews, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followers, through: :relationships, source: :follower
  has_many :followings, through: :reverse_of_relationships, source: :followed

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 1 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true
  enum gender: {
      unanswered: 0,
      male: 1,
      female: 2
  }

  def follow(user_id)
    self.relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    self.relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    self.followings.include?(user)
  end
end
