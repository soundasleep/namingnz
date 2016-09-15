require 'rails_helper'

RSpec.describe Cheque, type: :model do
  let(:user) { User.create! }
  let(:team_member) { user.team_members.create! name: "Test", email: "test@example.com", phone: "0" }
  let(:applicant) { Applicant.create! nickname: "cheque test" }
  let(:application) { applicant.applications.create! category: "name change" }
  let(:cheque) { application.cheques.create! amount: 100, payee: "IRD", team_member: team_member }

  subject { cheque }

  context "the cheque is brand new" do
    it { is_expected.to be_active }
  end

  context "the cheque has been cancelled" do
    before { cheque.update_attributes! cancelled_at: Time.zone.now }

    it { is_expected.to_not be_active }
  end

  context "the cheque has been spent" do
    before { cheque.update_attributes! spent_at: Time.zone.now }

    it { is_expected.to_not be_active }
  end
end
