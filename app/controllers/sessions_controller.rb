class SessionsController < ApplicationController
  def new; end

  def create
    employee = Employee.find_by(employee_id: params[:session][:employee_id])
    if employee && employee.authenticate(params[:session][:password])
    else
      flash.now[:danger] = '従業員コードとパスワードのどちらか、または両方が無効です'
      render 'new'
    end
  end
end
