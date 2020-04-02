require 'rails_helper'

RSpec.describe Attendance, type: :model do
  let(:employee) { create(:employee) }
  let(:attendance) { create(:attendance, employee: employee) }

  describe 'モデルのバリデーション' do
    it 'Employeeとの関連付け' do
      expect(attendance).to be_valid
    end

    it 'Employeeが削除されたら関連しているAttendaceも削除される' do
      expect(attendance).to be_valid
      expect { attendance.employee.destroy }.to change(Attendance, :count).by(-1)
    end

    it '乗務員コードがなければ無効' do
      attendance.employee_id = ' '
      expect(attendance).not_to be_valid
    end

    it 'ポイントが空なら無効' do
      attendance.point = ' '
      expect(attendance).not_to be_valid
    end
  end
end
