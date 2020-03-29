class EmployeesController < ApplicationController
  before_action :logged_in_employee, only: %i[index edit update destroy]
  before_action :admin_employee, only: %i[destroy]
  MAX_DISPLAY_EMPLOYEE = 20
  MAX_DISPLAY_ATTENDANCE = 13

  def index
    @employees = Employee.page(params[:page]).per(MAX_DISPLAY_EMPLOYEE)
  end

  def show
    @employee = Employee.find(params[:id])
    @attendances = @employee.attendances.page(params[:page]).per(MAX_DISPLAY_ATTENDANCE)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      log_in @employee
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to @employee
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

  # ログインしているか確認
  def logged_in_employee
    unless logged_in?
      flash[:danger] = 'ログインが必要です'
      redirect_to login_url
    end
  end

  def admin_employee
    redirect_to(login_url) unless current_employee.admin?
  end
end
