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

    # Create a new ApplicantStatus
    status = @applicant.applicant_statuses.create! status: ApplicantStatus::NEW, team_member: current_team_member
    status.applicant_status_notes.create! content: params[:notes], team_member: current_team_member

    # And create new Applications for each possible Application
    Application::VALID_CATEGORIES.each do |category|
      if params[:categories] && params[:categories][category]
        application = @applicant.applications.create! category: category

        status = application.application_statuses.create! status: ApplicationStatus::NEW, team_member: current_team_member
      end
    end

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
    params.require(:applicant).permit(:nickname, :form_details)
  end
end
