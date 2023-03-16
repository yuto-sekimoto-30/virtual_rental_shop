class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  protected
  def not_authenticated
    redirect_to login_path, danger: t('defaults.message.require_login')
  end

  def get_movie_data
    msnids = @user.tmdb_reviews.select('movie_state_name_id AS id, count(*) AS cnt').group(:movie_state_name_id)
    @msnid_array = [0, 0, 0, 0]
    msnids.each do |msnid|
      case msnid.id
      when 1
        @msnid_array[0] = msnid.cnt
      when 2
        @msnid_array[1] = msnid.cnt
      when 3
        @msnid_array[2] = msnid.cnt
      when 4
        @msnid_array[3] = msnid.cnt
      end
    end
    @msnid_sum = @msnid_array.sum
  end
end
