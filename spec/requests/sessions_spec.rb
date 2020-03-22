require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Session APIテスト' do
    context 'when 異常系' do
      it 'loginページにアクセスできる' do
        get login_path
        expect(response).to have_http_status(:success)
      end

      it '無効なパラメータの時はもう一度ページを表示する' do
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
