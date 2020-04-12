class SessionsController < ApplicationController
  def new; end

  def create
    employee = Employee.find_by(employee_id: params[:session][:employee_id])
    if employee&.authenticate(params[:session][:password])
      log_in employee
      redirect_to employee, notice: 'ログインしました'
    else
      flash.now[:danger] = '従業員コード・パスワードが正しくないか登録されていません'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to employees_path
  end
end
