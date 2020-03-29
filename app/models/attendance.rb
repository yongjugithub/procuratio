class Attendance < ApplicationRecord
  belongs_to :employee
  validates :employee_id, presence: true
  validates :point, presence: true
end
