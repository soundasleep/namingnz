class TeamMembersController < ApplicationController
  def dashboard
    @team_member = find_team_member
  end

  private

  def find_team_member
    TeamMember.find(params[:id])
  end
end
