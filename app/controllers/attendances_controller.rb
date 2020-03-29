class AttendancesController < ApplicationController
  before_action :logged_in_employee, only: %i[create destroy]

  def create; end

  def destroy; end
end
