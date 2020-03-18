require 'rails_helper'

RSpec.describe "Employees", type: :request do
  let(:employee) { create(:employee, employee_id: 1, name: 'test user', admin: 'false', password: 'password', password_confirmation: 'password') }

  describe "GET /employees" do
    it 'indexページにアクセスできる' do
      get employees_path
      expect(response).to have_http_status(200)
    end

    it 'newページにアクセスできる' do
      get new_employee_path
      expect(response).to have_http_status(200)
    end

    it 'showページにアクセスできる' do
      get employee_path(employee.id)
      expect(response).to have_http_status(200)
    end
  end
end
