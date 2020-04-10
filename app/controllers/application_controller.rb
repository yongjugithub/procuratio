class ApplicationController < ActionController::Base
  include SessionsHelper

  private
  # ログインしているか確認
  def logged_in_employee
    unless logged_in?
      flash[:danger] = 'ログインが必要です'
      redirect_to login_url
    end
  end

  # 管理者ユーザーか確認
  def admin_employee
    unless current_employee.admin?
      flash[:danger] = 'このページは管理者のみが閲覧できます'
      redirect_to(login_url)
    end
  end
end
