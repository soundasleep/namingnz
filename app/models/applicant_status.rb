class ApplicantStatus < ActiveRecord::Base
  NEW = "new"
  COMPLETED = "completed"

  VALID_STATUSES = [NEW, COMPLETED]

  belongs_to :team_member
  belongs_to :applicant

  validates :team_member, presence: true
  validates :applicant, presence: true
  validates :status, inclusion: { in: VALID_STATUSES, message: "'%{value}' is not a valid status" }
end