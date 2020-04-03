class AttendancesController < ApplicationController
  before_action :logged_in_employee, only: %i[index new create destroy]
  before_action :admin_employee, only: %i[index new create destroy]
  MAX_DISPLAY_ATTENDANCE = 10

  def index
    @attendances = Attendance.order('created_at DESC').page(params[:page]).per(MAX_DISPLAY_ATTENDANCE)
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      flash[:success] = 'モニタリングチェックが完了しました'
      redirect_to '/attendances'
    else
      render 'new'
    end
  end

  def destroy; end

  private

  def attendance_params
    params.require(:attendance).permit(:employee_id, :ride_at, :ride_in,
                                       :attr_one, :attr_two, :attr_three, :attr_four, :attr_five,
                                       :attr_six, :attr_seven, :attr_eight, :attr_nine, :attr_ten,
                                       :memo, :point)
  end
end
