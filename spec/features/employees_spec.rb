require 'rails_helper'

RSpec.describe 'Employees', type: :feature do
  let(:employee) { create(:employee, id: 1, password: 'admin', password_confirmation: 'admin') }

  it 'ユーザ登録 UIテスト' do
    visit '/employees/new'

    expect do
      fill_in 'employee_employee_id', with: '2'
      fill_in 'employee_name', with: 'test user'
      fill_in 'employee_password', with: 'password'
      fill_in 'employee_password_confirmation', with: 'password'
      click_button '新規登録'
      expect(page).to have_content '登録'
    end.to change(Employee, :count).by(1)
  end

  xit 'ログイン時　index UIテスト' do
    log_in_as(employee)
    visit '/employees'
    expect(page).to have_current_path('/employees')
  end

  it '未ログイン時　index UIテスト' do
    visit '/employees'
    expect(page).to have_current_path('/login')
    expect(page).to have_content 'ログインが必要です'
  end

  xit 'ログイン時 ユーザー情報編集 UIテスト' do
    log_in_as(employee)
    visit edit_employee_path(employee.id)
    expect(page).to have_current_path('/edit_employee_path')
  end

  it '未ログイン時 ユーザー情報編集 UIテスト' do
    visit edit_employee_path(employee.id)
    expect(page).to have_current_path('/login')
    expect(page).to have_content 'ログインが必要です'
  end
end
