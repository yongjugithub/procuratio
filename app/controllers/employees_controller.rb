class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new(employee_params)
    if @employee.save
    else
      render 'new'
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:employee_id, :name, :password, :password_confirmation)
  end
end
