require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let(:employee) { create(:employee, employee_id: 3, name: 'test user', admin: 'false', password: 'password', password_confirmation: 'password') }

  describe 'employeeページにアクセスできる' do
    xit 'indexページにアクセスできる' do
      get employees_path
      expect(response).to be_success
    end

    xit 'newページにアクセスできる' do
      get new_employee_path
      expect(response).to be_success
    end

    xit 'showページにアクセスできる' do
      get employee_path(employee.id)
      expect(response).to be_success
    end
  end
end
