module SessionsHelper
  def log_in(employee)
    session[:employee_id] = employee.id
  end
end
