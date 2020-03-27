class EmployeesController < ApplicationController
  before_action :logged_in_employee, only: %i[edit update]

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
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
end
