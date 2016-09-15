class Applicant < ActiveRecord::Base
  belongs_to :team_member

  has_many :applications, dependent: :destroy

  # TODO likely that this could be refactored into a concern or module?
  has_many :applicant_statuses, dependent: :destroy
  has_one :latest_status, class_name: "ApplicantStatus"

  scope :latest_statuses, -> { joins("JOIN applicant_statuses ON applicant_statuses.id = applicants.latest_status_id" ) }

  scope :active, -> { where("id NOT IN (?)", completed.empty? ? "" : completed.map(&:id)) }
  scope :completed, -> { latest_statuses.where("applicant_statuses.status" => "completed") }

  def update_status!(status:, team_member:)
    new_status = applicant_statuses.create! status: status, team_member: team_member
    update_attributes! latest_status_id: new_status.id
  end
  # TODO end refactor

end
