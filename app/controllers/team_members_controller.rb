class TeamMembersController < ApplicationController
  before_filter :must_be_team_member

  def index
    @team_members = TeamMember.all
  end

  def dashboard
    @team_member = find_team_member
    @warnings = @team_member.applicants.map do |applicant|
      CalculateApplicantWarnings.new(applicant: applicant).call
    end.flatten
  end

  def new
    user = User.find(params[:user_id])
    @team_member = TeamMember.new(user: user)
  end

  def create
    @team_member = TeamMember.new team_member_params
    @team_member.promoted_by = current_user
    @team_member.user = User.find(params[:team_member][:user_id])
    @team_member.save!

    flash[:notice] = "Team member created"
    redirect_to @team_member
  end

  def show
    @team_member = TeamMember.find params[:id]
  end

  def edit
    @team_member = TeamMember.find params[:id]
  end

  def update
    @team_member = TeamMember.find params[:id]
    @team_member.update team_member_params
    @team_member.save!

    flash[:notice] = "Team member profile updated"
    redirect_to @team_member
  end

  private

  def find_team_member
    TeamMember.find(params[:id])
  end

  def team_member_params
    params.require(:team_member).permit(:name, :email, :phone)
  end
end
