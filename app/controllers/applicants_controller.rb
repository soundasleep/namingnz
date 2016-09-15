class ApplicantsController < ApplicationController
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

  private

  def applicant_params
    params.require(:applicant).permit(:nickname)
  end
end
