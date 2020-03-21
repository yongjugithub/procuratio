require 'rails_helper'

RSpec.describe 'Employees', type: :feature do
  it 'ユーザ登録 UIテスト' do
    visit '/employees/new'

    expect do
      fill_in 'employee_employee_id', with: '1'
      fill_in 'employee_name', with: 'test user'
      fill_in 'employee_password', with: 'password'
      fill_in 'employee_password_confirmation', with: 'password'
      click_button '新規登録'
      expect(page).to have_content '登録'
    end.to change(Employee, :count).by(1)
  end
end
