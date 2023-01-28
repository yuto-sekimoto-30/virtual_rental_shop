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
    @popular_movies = JSON.parse(Tmdb::Movie.popular.to_json)['table']['results']

    #映画情報取得
    search = false
    @search_movies = []
    if !params[:name].blank? && !params[:type].blank? #検索された場合
      person_id = 0
      if params[:type] == "1" #映画名が選択された場合
        i = 1
        JSON.parse((Tmdb::Search.movie(params[:name])).to_json)['table']['total_pages'].times do
          @search_movies += JSON.parse((Tmdb::Search.movie(params[:name], page: "#{i}")).to_json)['table']['results']
          i += 1
          break if i > 6 # 120タイトル取得
        end
      elsif params[:type] == "2" #人物名が選択された場合
        person_id = JSON.parse((Tmdb::Search.person(params[:name])).to_json)['table']['results'][0]['table']['id']
        @search_movies = JSON.parse((Tmdb::Person.movie_credits(person_id)).to_json)['table']['cast']
      end
      search = true
    else #検索パラメーターがない場合
      ('A'..'Z').to_a.shuffle[0..5].each do |random_chara| #ランダムで120タイトル取得
        total_pages = JSON.parse((Tmdb::Search.movie(random_chara)).to_json)['table']['total_pages']
        @search_movies += JSON.parse((Tmdb::Search.movie(random_chara, page: rand(1..total_pages.to_i))).to_json)['table']['results']
      end
      @search_movies.shuffle!
    end

    #ジャンルが選択されていた場合
    if !params[:genre].blank?
      @search_movies.delete_if do |search_movie|
        #更にジャンルで絞る
        !search_movie['table']['genre_ids'].include?(params[:genre].to_i)
      end
    end

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
