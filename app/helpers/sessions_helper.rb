module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(employee)
    session[:employee_id] = employee.id
  end

  # ログインしているユーザーがいる場合、@current_employeeにユーザーを代入する
  def current_employee
    if session[:employee_id]
      @current_employee ||= Employee.find_by(id: session[:employee_id])
    end
  end
  
  # ログインいているユーザーがいればtrue,いなければnilを返す
  def logged_in?
    !current_employee.nil?
  end
end
