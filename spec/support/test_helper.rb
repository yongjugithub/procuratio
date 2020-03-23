module TestHelper
  def is_logged_in?
    !session[:employee_id].nil?
  end
end
