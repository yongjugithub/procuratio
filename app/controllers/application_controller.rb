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
end
