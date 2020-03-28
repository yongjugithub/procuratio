require 'rails_helper'

RSpec.describe 'Employees', type: :feature do
  # featureSpecではlog_in_asヘルパーメソッドが作動しない

  let(:employee) { create(:employee, id: 1, password: 'admin', password_confirmation: 'admin') }

  it 'ユーザ登録成功　ログイン状態 UIテスト' do
    visit '/employees/new'

    expect do
      fill_in 'employee_employee_id', with: '2'
      fill_in 'employee_name', with: 'test user'
      fill_in 'employee_password', with: 'password'
      fill_in 'employee_password_confirmation', with: 'password'
      click_button '新規登録'
      expect(page).to have_content '登録'
    end.to change(Employee, :count).by(1)

    # ログイン状態の各リンクにアクセスし、before_actionの機能が有効か確認
    visit '/employees'
    expect(page).to have_current_path('/employees')
    expect(page).to have_content 'ユーザー一覧'
    visit edit_employee_path(employee.id)
    expect(page).to have_current_path('/employees/1/edit')
    expect(page).to have_content '編集画面'
  end

  it '未ログイン時  アクセス制限テスト' do
    visit '/employees'
    expect(page).to have_current_path('/login')
    expect(page).to have_content 'ログインが必要です'
    visit edit_employee_path(employee.id)
    expect(page).to have_current_path('/login')
    expect(page).to have_content 'ログインが必要です'
  end
end
