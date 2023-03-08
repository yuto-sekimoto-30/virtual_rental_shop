class TmdbMovie
  include ActiveModel::Model

  attr_accessor :name, :title, :age
  validates :name, presence: true
end
