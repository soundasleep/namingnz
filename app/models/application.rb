class Application < ActiveRecord::Base
  belongs_to :applicant

  has_many :cheques, dependent: :nullify

  validates :applicant, presence: true

  # TODO likely that this could be refactored into a concern or module?
  has_many :application_statuses, dependent: :destroy
  has_one :latest_status, class_name: "ApplicationStatus"

  scope :latest_statuses, -> { joins("JOIN application_statuses ON application_statuses.id = applications.latest_status_id" ) }

  scope :active, -> { where("id NOT IN (?)", completed.empty? ? "" : completed.map(&:id)) }
  scope :completed, -> { latest_statuses.where("application_statuses.status" => "completed") }

  def update_status!(status:, team_member:)
    new_status = application_statuses.create! status: status, team_member: team_member
    update_attributes! latest_status_id: new_status.id
  end
  # TODO end refactor

end
