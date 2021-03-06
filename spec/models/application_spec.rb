require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:user) { User.create! }
  let(:team_member) { user.team_members.create! name: "Test", email: "test@example.com", phone: "0" }
  let(:applicant) { Applicant.create! nickname: "Test" }

  before do
    @first = applicant.applications.create! category: "name change"
    @second = applicant.applications.create! category: "name change"
  end

  # TODO likely that this could be refactored into a concern or module?

  context "neither Application has statues" do
    describe "#active" do
      it "there is two" do
        expect(Application.active.length).to eq(2)
      end
    end

    describe "#completed" do
      it "is empty" do
        expect(Application.completed).to be_empty
      end
    end

    describe "#votes" do
      it "is empty" do
        expect(@first.votes).to be_empty
        expect(@second.votes).to be_empty
      end
    end

    describe "#voted_yes?" do
      it "is false" do
        expect(@first).to_not be_voted_yes
        expect(@second).to_not be_voted_yes
      end
    end

    describe "#voted_no?" do
      it "is false" do
        expect(@first).to_not be_voted_no
        expect(@second).to_not be_voted_no
      end
    end

    context "when a Yes vote is registered" do
      before do
        @first.votes.create! vote: Vote::YES, team_member: team_member
      end

      describe "#votes" do
        it "is not empty" do
          expect(@first.votes).to_not be_empty
          expect(@second.votes).to be_empty
        end
      end

      describe "#voted_yes?" do
        it "is true" do
          expect(@first).to be_voted_yes
          expect(@second).to_not be_voted_yes
        end
      end

      describe "#voted_no?" do
        it "is false" do
          expect(@first).to_not be_voted_no
          expect(@second).to_not be_voted_no
        end
      end
    end
  end

  context "first Application has new status" do
    before do
      @first.update_status! status: ApplicationStatus::NEW, team_member: team_member
    end

    describe "#active" do
      it "there is two" do
        expect(Application.active.length).to eq(2)
      end
    end

    describe "#completed" do
      it "is empty" do
        expect(Application.completed).to be_empty
      end
    end

    describe "#latest_status" do
      it "is new" do
        expect(@first.latest_status.status).to eq(ApplicationStatus::NEW)
      end
    end
  end

  context "second Application has completed status" do
    before do
      @second.update_status! status: ApplicationStatus::COMPLETED, team_member: team_member
    end

    describe "#latest_status" do
      it "is set" do
        expect(@first.latest_status).to be_nil
        expect(@second.latest_status).to_not be_nil
      end
    end

    describe "#active" do
      it "there is one" do
        expect(Application.active.length).to eq(1)
        expect(Application.active.first).to eq(@first)
      end
    end

    describe "#completed" do
      it "is empty" do
        expect(Application.completed.length).to eq(1)
        expect(Application.completed.first).to eq(@second)
      end
    end

    describe "#latest_status" do
      it "is empty on the first one" do
        expect(@first.latest_status).to be_nil
      end

      it "is completed on the second one" do
        expect(@second.latest_status.status).to eq(ApplicationStatus::COMPLETED)
      end
    end
  end
end
