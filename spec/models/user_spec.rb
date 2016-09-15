require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create! }

  it "is not a team member" do
    expect(user).to_not be_team_member
  end

  context "when linked to a new team member" do
    before { user.team_members.create! name: "Test", email: "test@example.com", phone: "0" }

    it "is a team member" do
      expect(user).to be_team_member
    end
  end
end
