require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let(:employee) { create(:employee, id: 1) }

  describe 'Employeeモデル APIテスト' do
    context 'when 正常系 ユーザー登録' do
      it '有効な属性値の場合ユーザが登録され,リダイレクトされる' do
        get new_employee_path
        expect(response).to have_http_status(:success)
        expect do
          post employees_url, params: {
            employee: {
              employee_id: 1,
              name: 'test user',
              password: 'password',
              password_confirmation: 'password'
            }
          }
        end.to change(Employee, :count).by(1)
        expect(response.status).to eq 302
        # TestHelperを呼び出し、ログインしていたらtrueを返す
        expect(is_logged_in?).to be_truthy
      end
    end

    context 'when 異常系 ユーザー登録' do
      it '無効な属性値の場合ユーザが登録されず,リダイレクトされる' do
        expect do
          post employees_url, params: {
            employee: {
              employee_id: '',
              name: '',
              password: '',
              password_confirmation: ''
            }
          }
        end.to change(Employee, :count).by(0)
        expect(response.status).to eq 200
        # TestHelperを呼び出し、ログイン失敗でfalseを返す
        expect(is_logged_in?).to be_falsey
      end
    end

    context 'when 正常系 ユーザー情報編集' do
      it '有効な属性値の場合、リダイレクトされ成功メッセージを出す' do
        log_in_as(employee)
        get edit_employee_path(employee.id)
        expect(response).to have_http_status(:success)
        patch employee_path, params: {
          employee: {
            employee_id: '1',
            name: 'admin user',
            password: '',
            password_confirmation: ''
          }
        }
        expect(response.status).to eq 302
        render_template employees_path(employee.id)
      end
    end

    context 'when 異常系 ユーザー情報編集' do
      it '無効な属性値の場合、編集が失敗しリダイレクトされる' do
        log_in_as(employee)
        get edit_employee_path(employee.id)
        patch employee_path, params: {
          employee: {
            employee_id: '',
            name: '',
            password: '',
            password_confirmation: ''
          }
        }
        expect(response.status).to eq 200
        render_template edit_employee_path
        expect(response.body).to include 'error'
      end
    end
  end
end
