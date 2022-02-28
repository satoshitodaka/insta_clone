class Mypage::ActivitiesController < Mypage::BaseController
  before_action :require_login, only: %i[index]

  def index
    @activities = current_user.activities.order(created_at: :desc).page(params[:page]).per(10)
  end
end
