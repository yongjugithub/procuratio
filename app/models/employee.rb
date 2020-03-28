# == Schema Information

# Table name: employee
# employee_id :integer  not null
# name  :sting not null
# admin :boolean default: false not null

class Employee < ApplicationRecord
  validates :employee_id, presence: true, uniqueness: true
  validates :name, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
end
