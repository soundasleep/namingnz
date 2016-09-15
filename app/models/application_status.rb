class ApplicationStatus < ActiveRecord::Base
  NEW = "new"
  REMINDER_SENT = "reminder sent"
  CHEQUE_SENT = "cheque sent"
  CHEQUE_SPENT = "cheque spent"
  COMPLETED = "completed"
  CANCELLED = "cancelled"
  # TODO lots more statuses to put in here
  # 'asked for status update', 'status update received', 'contact details confirmed',
  # 'lost contact', 'contact resumed', 'assigned to', 'added to mailing list',
  # 'feedback form sent', 'feedback form received', 'note added', ...

  VALID_STATUSES = [NEW, REMINDER_SENT, CHEQUE_SENT, CHEQUE_SPENT, COMPLETED, CANCELLED]

  belongs_to :application
  belongs_to :team_member

  validates :status, inclusion: { in: VALID_STATUSES }
end
