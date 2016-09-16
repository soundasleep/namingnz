class ApplicationStatusNote < ActiveRecord::Base
  belongs_to :application_status
  belongs_to :team_member

  validates :team_member, presence: :true
end
