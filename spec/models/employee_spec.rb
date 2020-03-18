require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { create(:employee, employee_id: 1, name: 'test user', admin: 'false') }

  describe 'バリデーション' do
    it '乗務員コードと名前があれば有効' do
      expect(employee).to be_valid
    end

    it '重複した乗務員コードでは無効' do
      employee2 = employee.dup
      expect(employee2).not_to be_valid
    end
  end
end
