require 'rails_helper'

RSpec.describe 'Employees', type: :feature do
  # featureSpecではlog_in_asヘルパーメソッドが作動しない
  let(:employee) { create(:employee, id: 1, password: 'admin', password_confirmation: 'admin') }
  let!(:attendances) { create_list(:attendance, 14, employee: employee) }

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

    # ログイン状態の各リンクにアクセスし、ログイン制御が有効か確認
    # indexページ
    visit '/employees'
    expect(page).to have_current_path('/employees')
    expect(page).to have_content 'ユーザー一覧'
    # editページ
    visit edit_employee_path(employee.id)
    expect(page).to have_current_path('/employees/1/edit')
    expect(page).to have_content '編集画面'
    # showページ
    visit employee_path(employee.id)
    expect(page).to have_current_path(employee_path(employee.id))
    expect(page).to have_selector 'ul.pagination'
    expect(page).to have_selector 'ul.list-group'
    expect(page).to have_selector 'span.timestamp'
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
