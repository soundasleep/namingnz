require 'rails_helper'

RSpec.describe Applicant, type: :model do
  let(:user) { User.create! }
  let(:team_member) { user.team_members.create! name: "Test", email: "test@example.com", phone: "0" }

  before do
    @first = Applicant.create! nickname: "first"
    @second = Applicant.create! nickname: "second"
  end

  # TODO likely that this could be refactored into a concern or module?

  context "neither applicant has statues" do
    describe "#active" do
      it "there is two" do
        expect(Applicant.active.length).to eq(2)
      end
    end

    describe "#completed" do
      it "is empty" do
        expect(Applicant.completed).to be_empty
      end
    end

    describe "#voted?" do
      it "is false" do
        expect(@first).to_not be_voted
        expect(@second).to_not be_voted
      end
    end
  end

  context "first applicant has new status" do
    before do
      @first.update_status! status: ApplicantStatus::NEW, team_member: team_member
    end

    describe "#active" do
      it "there is two" do
        expect(Applicant.active.length).to eq(2)
      end
    end

    describe "#completed" do
      it "is empty" do
        expect(Applicant.completed).to be_empty
      end
    end

    describe "#latest_status" do
      it "is new" do
        expect(@first.latest_status.status).to eq(ApplicantStatus::NEW)
      end
    end
  end

  context "second applicant has completed status" do
    before do
      @second.update_status! status: ApplicantStatus::COMPLETED, team_member: team_member
    end

    describe "#latest_status" do
      it "is set" do
        expect(@first.latest_status).to be_nil
        expect(@second.latest_status).to_not be_nil
      end
    end

    describe "#active" do
      it "there is one" do
        expect(Applicant.active.length).to eq(1)
        expect(Applicant.active.first).to eq(@first)
      end
    end

    describe "#completed" do
      it "is empty" do
        expect(Applicant.completed.length).to eq(1)
        expect(Applicant.completed.first).to eq(@second)
      end
    end

    describe "#latest_status" do
      it "is empty on the first one" do
        expect(@first.latest_status).to be_nil
      end

      it "is completed on the second one" do
        expect(@second.latest_status.status).to eq(ApplicantStatus::COMPLETED)
      end
    end
  end
end
