require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Session APIテスト' do
    let(:employee) { create(:employee) }

    context 'when 正常系' do
      it '有効なユーザーでログインし、ページを偏移する、その後ログアウトする' do
        get login_path
        expect(response).to have_http_status(:success)
        post login_path, params: {
          session: {
            employee_id: employee.id,
            password: employee.password
          }
        }
        expect(response).to have_http_status(:success)
        render_template employee_path(employee.id)
        delete logout_path
        # TestHelperを呼び出し、ログアウトしていればfalseを返す
        expect(is_logged_in?).to be_falsey
        expect(response.status).to eq 302
        render_template employees_path
      end
    end

    context 'when 異常系' do
      it '再度ログインページを表示し、エラーメッセージも追加する' do
        post login_path, params: {
          session: {
            employee_id: '',
            password: ''
          }
        }
        expect(response.status).to eq 200
        render_template login_path
        expect(response.body).to include '従業員コード・パスワードが正しくないか登録されていません'
      end
    end
  end
end
