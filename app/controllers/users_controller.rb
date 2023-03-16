class UsersController < ApplicationController
  include TmdbKey
  before_action :set_user, only: %i[show edit update]
  before_action :require_login, only: %i[index show edit update]
  before_action :new_user, only: %i[new]
  before_action :user_authority, only: %i[edit update]
  before_action :get_pagination_movies, only: %i[show]
  before_action :get_movie_data, only: %i[show edit update]
  layout 'profile', only: %i[show edit update]

  def show; end
  def new; end

  def edit
    @tmdb_reviews = current_user.tmdb_reviews
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, success: t('.success')
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), success: t('.success')
    else
      flash.now[:danger] = t '.fail'
      render :edit
    end
  end

  private
  def new_user
    @user = User.new
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :birth_date, :gender, :introduction, :password, :password_confirmation, :avatar, :avatar_cache)
  end

  def user_authority
    if params[:id].to_i != current_user.id
      redirect_to user_path(current_user), success: "権限がありません"
    end
  end

  def get_pagination_movies
    #項目の映画情報を取得
    if params[:msnid].present?
      @msnid = params[:msnid].to_i  # 現在の取得項目
      kind_movies = @user.tmdb_reviews.where(movie_state_name_id: @msnid.to_i) if @msnid.present?
    else
      kind_movies = @user.tmdb_reviews
    end
    # 画面に表示する映画情報取得
    display_num = 18 #画面に表示する件数
    @current_page = params[:page].present? ? params[:page].to_i : 1 # 現在のページ
    display_movies = kind_movies.limit(display_num).offset((@current_page- 1) * display_num)
    @movies = []
    display_movies.each do |movie|
      @movies.push(JSON.parse(Tmdb::Movie.detail(movie.tmdb_id).to_json)["table"])
    end
    # ページ数合計
    movies_total = kind_movies.count.to_f
    @pages = (movies_total / display_num).ceil
    #画面に表示するページネーション数
    pagination_num = 9
    # 画面に表示する最大ページネーション数
    @max_pages = @pages < pagination_num ? @pages : pagination_num
    # ページネーションの左右最大数
    max_right_pages = 4
    max_left_pages = 4
    # 最初のページネーションの位置を取得
    if @pages > pagination_num && @current_page > max_left_pages + 1
      # 右のページネーション数を取得
      right_pages = @pages - @current_page
      right_pages = max_right_pages if right_pages > max_right_pages
      # 最初のページネーションの位置
      @first_page = @current_page - (@max_pages - (right_pages + 1))
    else
      # 最初のページネーションの位置
      @first_page = 1
    end
  end
end
