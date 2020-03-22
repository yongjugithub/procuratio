require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Session APIテスト' do
    context 'when 異常系' do
      it 'loginページにアクセスできる' do
        get login_path
        expect(response).to have_http_status(:success)
      end

      it '無効な値の時は再度ページを表示し、エラーメッセージも追加する' do
        post login_path, params: {
          session: {
            employee_id: '',
            password: ''
          }
        }
        expect(response.status).to eq 200
        expect(response.body).to include '無効'
      end
    end
  end
end
