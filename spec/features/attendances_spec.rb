require 'rails_helper'

RSpec.describe 'Attendances', type: :feature do
  let!(:admin_employee) { create(:employee, employee_id: 1, password: 'admin', password_confirmation: 'admin', admin: true) }
  let!(:non_admin) { create(:employee, employee_id: 2, password: 'password', password_confirmation: 'password') }

  context '未ログイン' do
    it 'attendance[new]にアクセス不可' do
      visit '/attendances/new'
      expect(page).to have_current_path('/login')
      expect(page).to have_content 'ログインが必要です'
    end
  end

  context '管理者としてログイン' do
    it 'attendances/newページにアクセス可能' do
      # let!で事前に作成したadmin_employeeとしてログインする
      visit '/login'
      fill_in 'session_employee_id', with: '1'
      fill_in 'session_password', with: 'admin'
      click_button 'ログイン'

      visit '/attendances/new'
      expect(page).to have_current_path('/attendances/new')
    end
  end

  context '一般ユーザーとしてログイン' do
    it 'attendances/newページにアクセス不可' do
      # let!で事前に作成したnon_admin_employeeとしてログインする
      visit '/login'
      fill_in 'session_employee_id', with: '2'
      fill_in 'session_password', with: 'password'
      click_button 'ログイン'

      visit '/attendances/new'
      expect(page).to have_current_path('/login')
    end
  end
end
