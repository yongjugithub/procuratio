require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  describe 'ユーザー登録 APIテスト' do
    context 'when 正常系' do
      it '新規登録ページにアクセスできる' do
        get new_employee_path
        expect(response).to have_http_status(:success)
      end

      it '有効な属性値の場合ユーザが登録され,リダイレクトされる' do
        expect do
          post employees_url, params: {
            employee: {
              employee_id: 3,
              name: 'test user',
              password: 'password',
              password_confirmation: 'password'
            }
          }
        end.to change(Employee, :count).by(1)
        expect(response.status).to eq 302
      end
    end

    xcontext '異常系' do
    end
  end
end
