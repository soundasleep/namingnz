class AssignApplicantToTeamMember
  attr_reader :team_member, :applicant

  def initialize(team_member:, applicant:)
    @team_member = team_member
    @applicant = applicant
  end

  def call
    @applicant.update_attributes! team_member: team_member
    # TODO add some logging
  end
end
