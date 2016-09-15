class ApplicationsController < ApplicationController
  before_filter :must_be_team_member

  def new
    @applicant = find_applicant
    @application = @applicant.applications.new
  end

  def create
    @applicant = find_applicant
    @application = @applicant.applications.new application_params
    @application.save!
    flash[:notice] = "Application for #{@application.category} created"
    redirect_to [@applicant, @application]
  end

  def show
    @applicant = find_applicant
    @application = @applicant.applications.find(params[:id])
  end

  private

  def find_applicant
    @applicant ||= Applicant.find(params[:applicant_id])
  end

  def application_params
    params.require(:application).permit(:category)
  end
end
