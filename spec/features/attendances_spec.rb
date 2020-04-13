require 'rails_helper'

RSpec.describe 'Attendances', type: :feature do
  let!(:admin_employee) { create(:employee, employee_id: 1, password: 'admin', password_confirmation: 'admin', admin: true) }
  let!(:non_admin) { create(:employee, employee_id: 2, password: 'password', password_confirmation: 'password') }
  let!(:attendances) { create_list(:attendance, 11, employee: admin_employee) }

  context '未ログイン' do
    it 'attendance[new]にアクセス不可' do
      visit '/attendances/new'
      expect(page).to have_current_path('/login')
      expect(page).to have_content 'ログインが必要です'
    end

    it 'attendance[index]にアクセス不可' do
      visit '/attendances'
      expect(page).to have_current_path('/login')
      expect(page).to have_content 'ログインが必要です'
    end
  end

  context '管理者としてログイン' do
    before do
      # let!で事前に作成したadmin_employeeとしてログインする
      visit '/login'
      fill_in 'session_employee_id', with: '1'
      fill_in 'session_password', with: 'admin'
      click_button 'ログイン'
    end

    it 'attendances[new] にアクセス可能' do
      visit '/attendances/new'
      expect(page).to have_no_content 'このページは管理者のみが閲覧できます'
      expect(page).to have_current_path('/attendances/new')
    end

    it 'attendances[index] にアクセス可能' do
      visit '/attendances'
      expect(page).to have_no_content 'このページは管理者のみが閲覧できます'
      expect(page).to have_current_path('/attendances')
      # paginationが機能しているか
      expect(page).to have_selector 'ul.pagination'
      expect(page).to have_selector 'table'
      # ユーザーのリンクが存在するか
      expect(page).to have_link admin_employee.name
    end

    it '無効な値のときエラーメッセージとともに再度フォームを描画する' do
      visit '/attendances/new'
      fill_in 'attendance_employee_id', with: ''
      fill_in 'attendance_point', with: ''
      click_button 'チェック完了'
      expect(page).to have_content 'error'
      # 無効な登録データをPOSTするとURLが /attendances に変わる
      expect(page).to have_current_path('/attendances')
    end

    it '有効な値のときサクセスメッセージとともに指定のページに偏移する' do
      visit '/attendances/new'
      fill_in 'attendance_employee_id', with: non_admin.id
      fill_in 'attendance_point', with: '9'
      click_button 'チェック完了'
      expect(page).to have_content 'チェック結果が保存されました'
      expect(page).to have_current_path('/attendances')
    end
  end

  context '一般ユーザーとしてログイン' do
    before do
      # let!で事前に作成したnon_admin_employeeとしてログインする
      visit '/login'
      fill_in 'session_employee_id', with: '2'
      fill_in 'session_password', with: 'password'
      click_button 'ログイン'
    end

    it 'attendances/new にアクセス不可' do
      visit '/attendances/new'
      expect(page).to have_content 'このページは管理者のみが閲覧できます'
      expect(page).to have_current_path('/login')
    end

    it 'attendances/index にアクセス不可' do
      visit '/attendances'
      expect(page).to have_content 'このページは管理者のみが閲覧できます'
      expect(page).to have_current_path('/login')
    end
  end
end
