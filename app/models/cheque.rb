class Cheque < ActiveRecord::Base
  belongs_to :team_member
  belongs_to :application

  validates :application, presence: true
  validates :team_member, presence: true

  delegate :applicant, to: :application

  def active_for_days
    ((Time.zone.now - created_at).to_i) / 1.days
  end

  def active?
    !spent_at.present? && !cancelled_at.present?
  end
end
