require 'rails_helper'

RSpec.describe 'Employees', type: :feature do
  let(:employee) { create(:employee) }

  it '共通ヘッダーのリンクからトップページに移動できる' do
    visit '/employees/new'
    expect(page).to have_link 'Procuratio'
    click_on 'Procuratio'
    expect(page).to have_current_path('/employees')
  end

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

  it '未ログイン時 ユーザー情報編集 UIテスト' do
    visit edit_employee_path(employee.id)
    expect(page).to have_content 'ログインが必要です'
  end
end
