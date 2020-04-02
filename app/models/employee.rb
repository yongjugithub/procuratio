class Employee < ApplicationRecord
  validates :employee_id, presence: true, uniqueness: true
  validates :name, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
  has_many :attendances, dependent: :destroy
end
