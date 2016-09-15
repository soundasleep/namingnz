require 'rails_helper'

RSpec.describe ApplicantStatus, type: :model do
  let(:user) { User.create! }
  let(:team_member) { user.team_members.create name: "Team member", email: "test@example.com", phone: "0" }
  let(:applicant) { Applicant.create nickname: "Test" }

  describe "validation on #status" do
    subject { ApplicantStatus.create applicant: applicant, team_member: team_member, status: status }

    context "nil status" do
      let(:status) { nil }

      it { is_expected.to_not be_valid }
    end

    context "new status" do
      let(:status) { "new" }

      it { is_expected.to be_valid }
    end

    context "completed status" do
      let(:status) { "completed" }

      it { is_expected.to be_valid }
    end

    context "invalid_status status" do
      let(:status) { "invalid_status" }

      it { is_expected.to_not be_valid }
    end
  end
end
