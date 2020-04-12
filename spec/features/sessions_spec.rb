require 'rails_helper'

RSpec.describe 'Sessions', type: :feature do
  let!(:employee) { create(:employee, id: 1, password: 'admin', password_confirmation: 'admin') }

  it 'ログイン失敗時　UIテスト' do
    visit '/login'
    fill_in 'session_employee_id', with: ''
    fill_in 'session_password', with: ''
    click_button 'ログイン'
    expect(page).to have_current_path('/login')
    expect(page).to have_content '従業員コード・パスワードが正しくないか登録されていません'
  end

  it 'ログイン成功からログアウト UIテスト' do
    visit '/login'
    fill_in 'session_employee_id', with: 1
    fill_in 'session_password', with: 'admin'
    click_button 'ログイン'
    expect(page).to have_current_path('/employees/1')
    expect(page).to have_content 'ログインしました'
    expect(page).to have_link 'プロフィール'
    expect(page).to have_link '編集'
    expect(page).to have_link 'ログアウト'
    click_on 'ログアウト'
    expect(page).to have_current_path('/login')
  end
end
