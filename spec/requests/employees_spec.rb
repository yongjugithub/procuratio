require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let(:admin_employee) { create(:employee, id: 1, admin: true) }
  let(:non_admin) { create(:employee, id: 2, admin: false) }

  describe 'Employeeモデル APIテスト' do
    context 'when ユーザー登録' do
      it '有効な属性値の場合ユーザが登録され,リダイレクトされる' do
        get new_employee_path
        expect(response).to have_http_status(:success)
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
        # TestHelperを呼び出し、ログインしていたらtrueを返す
        expect(is_logged_in?).to be_truthy
      end
    end

    context 'ユーザー登録' do
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

    context 'ログイン' do
      it '有効な属性値の場合、編集が成功する' do
        log_in_as(admin_employee)
        get edit_employee_path(admin_employee.id)
        expect(response).to have_http_status(:success)
        patch employee_path, params: {
          employee: {
            employee_id: '1',
            name: 'admin',
            password: '',
            password_confirmation: ''
          }
        }
        expect(response.status).to eq 302
        render_template employees_path(admin_employee.id)
      end
    end

    context 'ログイン' do
      it '無効な属性値の場合、編集が失敗する' do
        log_in_as(admin_employee)
        get edit_employee_path(admin_employee.id)
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

    context '未ログイン' do
      it 'ユーザー情報編集へアクセス時、ログイン画面にリダイレクトされる' do
        get edit_employee_path(admin_employee.id)
        render_template login_path
      end
      it 'PATCHリクエストが拒否される' do
        get edit_employee_path(admin_employee.id)
        patch employee_url, params: {
          employee: {
            employee_id: 1,
            name: 'test user',
            password: 'password',
            password_confirmation: 'password'
          }
        }
        render_template login_path
      end
    end

    context '管理者権限の制御' do
      it '一般ユーザーがログイン時は、他のユーザを削除できない' do
        log_in_as(non_admin)
        expect do
          delete employee_url(1)
        end.to change(Employee, :count).by(0)
        render_template login_path
      end

      it '管理者ユーザーがログイン時は、他のユーザを削除できる' do
        log_in_as(admin_employee)
        expect do
          delete employee_url(1)
        end.to change(Employee, :count).by(-1)
        render_template employees_path
      end
    end
  end
end
