module TestHelper
  def is_logged_in?
    !session[:employee_id].nil?
  end

  def log_in_as(employee)
    post login_path, params: {
      session: {
        employee_id: employee.id,
        password: employee.password
      }
    }
  end
end
