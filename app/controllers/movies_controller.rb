class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_login, only: %i[show]

  require 'themoviedb-api'
  Tmdb::Api.key("a345acb42340ca68939f4c241dc52adb")
  Tmdb::Api.language("ja")

  def tmdb_id
    tmdb_id = params[:tmdb_id]
    render :json => tmdb_id
  end

  def index
    #映画ジャンル取得
    @genre_array = []
    genre = JSON.parse((Tmdb::Genre.movie_list).to_json)
    i = 0
    genre.count.times do
      @genre_array.push genre[i]['table'].values.reverse
      i += 1
    end

    #人気映画取得
    @movies_pops = JSON.parse(Tmdb::Movie.popular.to_json)['table']['results']

    #検索映画取得
    #検索名パラメータがある場合
    if !params[:name].blank?
      total_page = JSON.parse((Tmdb::Search.movie(params[:name])).to_json)['table']['total_pages']
      name = true
    elsif !params[:genre].blank?
      total_page = JSON.parse((Tmdb::Genre.movies(params[:genre])).to_json)['table']['total_pages']
      genre = true
    else
      rand_alpha = ('a'..'z').to_a.shuffle[0]
      total_page = JSON.parse((Tmdb::Search.movie(rand_alpha)).to_json)['table']['total_pages']
      random = true
    end

    i = 1
    @search_movies = []
    total_page.times do 
      if name || random
        param_name = params[:name] if name
        param_name = rand_alpha if random
        @search_movies += JSON.parse((Tmdb::Search.movie(param_name, page: "#{i}")).to_json)['table']['results']
      elsif genre
        @search_movies += JSON.parse((Tmdb::Genre.movies(params[:genre], page: "#{i}")).to_json)['table']['results']
      end
      i += 1
      break if i > 6
    end

    #nameとgenreパラメータが両方ある場合
    if name && !params[:genre].empty?
      i = 0
      kari = []
      @search_movies.count.times do
        #更にジャンルで絞る
        if @search_movies[i]['table']['genre_ids'].include?(params[:genre].to_i)
          kari.push @search_movies[i]
        end
        i += 1
      end
      @search_movies = kari
    end
    puts @search_movies
  end
  
  def show
    @movie = JSON.parse((Tmdb::Movie.detail(params[:id])).to_json)['table']
    if @movie['poster_path'].blank?
      @movie['poster_path'] = "/assets/no_phone.jpg"
    else
      @movie['poster_path'] = 'https://image.tmdb.org/t/p/w1280' + @movie['poster_path']
    end
    @movie['backdrop_path'] = 'https://image.tmdb.org/t/p/w1280' + @movie['backdrop_path'] if !@movie['backdrop_path'].blank?
    @movie['overview'] = "詳細不明" if @movie['overview'].blank?

    @tmdb_comments = TmdbComment.where(tmdb_id: @movie['id'])
  end
end
