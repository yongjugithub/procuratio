require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Session APIテスト' do
    let(:employee) { create(:employee) }

    context 'when 正常系' do
      it 'loginページにアクセスできる' do
        get login_path
        expect(response).to have_http_status(:success)
      end

      it 'ログインする、ログインユーザーのページへ偏移する' do
        post login_path, params: {
          session: {
            employee_id: employee.id,
            password: employee.password
          }
        }
        expect(response).to have_http_status(:success)
        render_template employee_path(employee.id)
      end
    end

    context 'when 異常系' do
      it 'loginページにアクセスできる' do
        get login_path
        expect(response).to have_http_status(:success)
      end

      it '再度ログインページを表示し、エラーメッセージも追加する' do
        post login_path, params: {
          session: {
            employee_id: '',
            password: ''
          }
        }
        expect(response.status).to eq 200
        render_template login_path
        expect(response.body).to include '無効'
      end
    end
  end
end
