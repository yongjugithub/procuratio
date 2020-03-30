class AttendancesController < ApplicationController
  before_action :logged_in_employee, only: %i[new create destroy]

  def new
    @attendance = Attendance.new
  end

  def create; end

  def destroy; end
end
