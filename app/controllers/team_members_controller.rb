class TeamMembersController < ApplicationController
  def dashboard
    @team_member = find_team_member
    @warnings = @team_member.applicants.map do |applicant|
      CalculateApplicantWarnings.new(applicant: applicant).call
    end.flatten
  end

  private

  def find_team_member
    TeamMember.find(params[:id])
  end
end
