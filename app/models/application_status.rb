class ApplicationStatus < ActiveRecord::Base
  NEW = "new"
  ACCEPTED = "accepted"
  DECLINED = "declined"
  REMINDER_SENT = "reminder sent"
  CHEQUE_SENT = "cheque sent"
  CHEQUE_SPENT = "cheque spent"
  COMPLETED = "completed"
  CANCELLED = "cancelled"
  # TODO lots more statuses to put in here
  # 'asked for status update', 'status update received', 'contact details confirmed',
  # 'lost contact', 'contact resumed', 'assigned to', 'added to mailing list',
  # 'feedback form sent', 'feedback form received', 'note added', ...

  VALID_STATUSES = [NEW, ACCEPTED, DECLINED, REMINDER_SENT, CHEQUE_SENT, CHEQUE_SPENT, COMPLETED, CANCELLED]

  belongs_to :application
  belongs_to :team_member

  has_many :application_status_notes, dependent: :destroy

  validates :status, inclusion: { in: VALID_STATUSES }

  scope :ordered, -> { order(created_at: :desc) }
end
