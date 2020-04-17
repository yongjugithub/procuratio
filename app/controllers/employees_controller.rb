class EmployeesController < ApplicationController
  before_action :logged_in_employee, only: %i[index show new create edit update destroy]
  before_action :admin_employee, only: %i[destroy]
  MAX_DISPLAY_EMPLOYEE = 10
  MAX_DISPLAY_ATTENDANCE = 13

  def index
    @employees = Employee.page(params[:page]).per(MAX_DISPLAY_EMPLOYEE)
  end

  def show
    @employee = Employee.find(params[:id])
    @attendances = @employee.attendances.order('created_at DESC').page(params[:page]).per(MAX_DISPLAY_ATTENDANCE)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to employees_path
    else
      render 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      flash[:success] = '編集に成功しました'
      redirect_to @employee
    else
      render 'edit'
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    flash[:success] = 'ユーザーを削除しました'
    redirect_to employees_url
  end

  private

  def employee_params
    params.require(:employee).permit(:employee_id, :name, :password, :password_confirmation)
  end
end
