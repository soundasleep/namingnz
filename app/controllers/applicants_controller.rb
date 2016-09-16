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
    @applicant.update_status! status: ApplicantStatus::NEW, team_member: current_team_member, notes: params[:notes]

    # And create new Applications for each possible Application
    Application::VALID_CATEGORIES.each do |category|
      if params[:categories] && params[:categories][category]
        application = @applicant.applications.create! category: category

        application.update_status! status: ApplicationStatus::NEW, team_member: current_team_member, notes: params[:notes]
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

  def mass_vote
    applicant = Applicant.find params[:id]
    votes = []
    notes = params[:notes]

    # TODO this should really go into a service
    applicant.applications.each do |application|
      TeamMember.all.each do |team_member|
        if params[:vote] && params[:vote][application.id.to_s] && params[:vote][application.id.to_s][team_member.id.to_s]
          value = params[:vote][application.id.to_s][team_member.id.to_s]
          votes << application.votes.create!(vote: value, team_member: team_member)
        end
      end

      # now change the status of each
      if application.voted_yes?
        application.update_status! status: ApplicationStatus::ACCEPTED, team_member: current_team_member, notes: notes
      elsif application.voted_no?
        application.update_status! status: ApplicationStatus::DECLINED, team_member: current_team_member, notes: notes
      end
    end

    applicant.reload
    if applicant.voted? && applicant.latest_status.status != ApplicantStatus::IN_PROGRESS
      applicant.update_status! status: ApplicantStatus::IN_PROGRESS, team_member: current_team_member, notes: notes
    end

    # Assign to team member
    team_member = TeamMember.find(params[:team_member_id])
    applicant.team_member = team_member
    applicant.save!

    flash[:notice] = "#{votes.count} votes saved and applicant assigned to #{team_member}"
    redirect_to applicant
  end

  private

  def applicant_params
    params.require(:applicant).permit(:nickname, :form_details)
  end
end
