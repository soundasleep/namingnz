class Application < ActiveRecord::Base
  NAME_CHANGE = "name change"
  DRIVERS_LICENSE = "NZ drivers license"
  BIRTH_CERTIFICATE_CHANGE = "NZ birth certificate change"
  BIRTH_CERTIFICATE_COPIES = "NZ birth certificate copies"
  INTL_BIRTH_CERTIFICATE_CHANGE = "International birth certificate change"
  PASSPORT_NEW = "new NZ passport"
  PASSPORT_CHANGE = "NZ passport change"
  INTL_PASSPORT_CHANGE = "international passport change"
  UNIVERSITY_ID = "university ID"
  SCHOOL_ID = "school ID"
  OTHER = "other"

  VALID_CATEGORIES = [NAME_CHANGE, DRIVERS_LICENSE,
    BIRTH_CERTIFICATE_CHANGE, BIRTH_CERTIFICATE_COPIES,
    INTL_BIRTH_CERTIFICATE_CHANGE, PASSPORT_NEW, PASSPORT_CHANGE,
    INTL_PASSPORT_CHANGE, INTL_PASSPORT_CHANGE, UNIVERSITY_ID,
    SCHOOL_ID, OTHER]

  belongs_to :applicant

  has_many :cheques, dependent: :nullify
  has_many :votes, dependent: :destroy

  validates :applicant, presence: true
  validates :category, inclusion: { in: VALID_CATEGORIES }

  delegate :team_member, to: :applicant

  # TODO likely that this could be refactored into a concern or module?
  has_many :application_statuses, dependent: :destroy

  scope :latest_statuses, -> { joins("JOIN application_statuses ON application_statuses.id = applications.latest_status_id" ) }

  scope :active, -> { where("id NOT IN (?)", completed.empty? ? "" : completed.map(&:id)) }
  scope :completed, -> { latest_statuses.where("application_statuses.status" => "completed") }

  def update_status!(status:, team_member:, notes: nil)
    new_status = application_statuses.create! status: status, team_member: team_member
    update_attributes! latest_status_id: new_status.id
    if notes.present?
      new_status.application_status_notes.create! content: notes, team_member: team_member
    end
  end

  def latest_status
    ApplicationStatus.find(latest_status_id) if latest_status_id
  end
  # TODO end refactor

  def voted_yes?
    votes.where(vote: Vote::YES).count > votes.where(vote: Vote::NO).count
  end

  def voted_no?
    votes.where(vote: Vote::NO).count > votes.where(vote: Vote::YES).count
  end
end
