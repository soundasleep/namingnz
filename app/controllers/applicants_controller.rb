class ApplicantsController < ApplicationController
  before_filter :must_be_team_member

  def index
    @applicants = Applicant.all
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new applicant_params
    @applicant.save!

    flash[:notice] = "Applicant created"
    redirect_to @applicant
  end

  def show
    @applicant = Applicant.find params[:id]
  end

  def assign
    applicant = Applicant.find params[:id]
    team_member = TeamMember.find(params[:applicant][:team_member_id])
    applicant.team_member = team_member
    applicant.save!

    flash[:notice] = "Applicant assigned to #{team_member}"
    redirect_to applicant
  end

  private

  def applicant_params
    params.require(:applicant).permit(:nickname)
  end
end
