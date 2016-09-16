class ApplicationStatusNote < ActiveRecord::Base
  belongs_to :application_status
  belongs_to :team_member

  validates :team_member, presence: :true

  scope :ordered, -> { order(created_at: :desc) }
end
