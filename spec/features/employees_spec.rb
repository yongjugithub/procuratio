require 'rails_helper'

RSpec.describe 'Employees', type: :feature do
  # featureSpecではlog_in_asヘルパーメソッドが作動しない
  let!(:admin_employee) { create(:employee, employee_id: 1, password: 'admin', password_confirmation: 'admin', admin: true) }
  let!(:attendances) { create_list(:attendance, 14, employee: admin_employee) }

  context '未ログイン時' do
    it '[show]にアクセス不可' do
      visit employee_path(admin_employee.id)
      expect(page).to have_current_path('/login')
      expect(page).to have_content 'ログインが必要です'
    end

    it '[index]にアクセス不可' do
      visit '/employees'
      expect(page).to have_current_path('/login')
      expect(page).to have_content 'ログインが必要です'
    end

    it '[edit]にアクセス不可' do
      visit edit_employee_path(admin_employee.id)
      expect(page).to have_current_path('/login')
      expect(page).to have_content 'ログインが必要です'
    end
  end

  context '管理者としてログイン' do
    before do
      visit '/login'
      fill_in 'session_employee_id', with: 1
      fill_in 'session_password', with: 'admin'
      click_button 'ログイン'
    end

    it '[index]にアクセスできる' do
      visit '/employees'
      expect(page).to have_current_path(employees_path)
      expect(page).to have_content 'ユーザー一覧'
    end

    it '[edit]にアクセスできる' do
      visit edit_employee_path(admin_employee.id)
      expect(page).to have_current_path(edit_employee_path(admin_employee.id))
      expect(page).to have_content '編集画面'
    end

    it '[show]にアクセスできる' do
      visit employee_path(admin_employee.id)
      expect(page).to have_current_path(employee_path(admin_employee.id))
      # paginationが機能しているか
      expect(page).to have_selector 'ul.pagination'
      expect(page).to have_selector 'table'
    end

    it '有効な値で一般ユーザーを新規作成できる' do
      visit '/employees/new'

      expect do
        fill_in 'employee_employee_id', with: '2'
        fill_in 'employee_name', with: 'test user'
        fill_in 'employee_password', with: 'password'
        fill_in 'employee_password_confirmation', with: 'password'
        click_button '新規登録'
        expect(page).to have_content 'ユーザー登録が完了しました'
      end.to change(Employee, :count).by(1)

      # indexにリダイレクトする
      expect(page).to have_current_path(employees_path)
      expect(page).to have_selector 'div.alert-success'
    end
  end
end
