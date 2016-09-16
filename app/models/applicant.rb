class Applicant < ActiveRecord::Base
  belongs_to :team_member

  has_many :applications, dependent: :destroy

  validates :nickname, presence: :true

  # TODO likely that this could be refactored into a concern or module?
  has_many :applicant_statuses, dependent: :destroy

  scope :latest_statuses, -> { joins("JOIN applicant_statuses ON applicant_statuses.id = applicants.latest_status_id" ) }

  scope :active, -> { where("id NOT IN (?)", completed.empty? ? "" : completed.map(&:id)) }
  scope :completed, -> { latest_statuses.where("applicant_statuses.status" => "completed") }

  def update_status!(status:, team_member:, notes: nil)
    new_status = applicant_statuses.create! status: status, team_member: team_member
    update_attributes! latest_status_id: new_status.id
    if notes.present?
      new_status.applicant_status_notes.create! content: notes, team_member: team_member
    end
  end

  def latest_status
    ApplicantStatus.find(latest_status_id) if latest_status_id
  end
  # TODO end refactor

  def latest_notes
    applicant_statuses.joins(:applicant_status_notes).ordered
  end

  def voted?
    !applications.map(&:votes).flatten.empty?
  end

  def pending_applications_to_vote_on
    applications.select { |application| application.votes.empty? }
  end
end
