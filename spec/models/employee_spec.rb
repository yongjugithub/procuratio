require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { create(:employee, employee_id: 1, name: 'test user', admin: 'false', password: 'password', password_confirmation: 'password') }

  describe 'モデルのバリデーション' do
    it '乗務員コードと名前があれば有効' do
      expect(employee).to be_valid
    end

    it '重複した乗務員コードでは無効' do
      employee2 = employee.dup
      expect(employee2).not_to be_valid
    end

    it '名前がなければ、無効' do
      employee.name = ' '
      expect(employee).not_to be_valid
    end

    it '管理者権限をもつことができる' do
      employee.admin = true
      expect(employee).to be_valid
    end
  end
end
