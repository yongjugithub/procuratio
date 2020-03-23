class SessionsController < ApplicationController
  def new; end

  def create
    employee = Employee.find_by(employee_id: params[:session][:employee_id])
    if employee&.authenticate(params[:session][:password])
      log_in employee
      redirect_to employee
    else
      flash.now[:danger] = '従業員コードとパスワードのどちらか、または両方が無効です'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to new_employee_path
  end
end
