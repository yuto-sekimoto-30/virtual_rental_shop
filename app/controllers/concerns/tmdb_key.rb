module TmdbKey
  extend ActiveSupport::Concern

  included do
    require 'themoviedb-api'
    Tmdb::Api.key(Rails.application.credentials.tmdb[:access_key_id])
    Tmdb::Api.language("ja")
  end
end
