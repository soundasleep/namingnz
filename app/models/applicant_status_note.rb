class ApplicantStatusNote < ActiveRecord::Base
  belongs_to :applicant_status
  belongs_to :team_member

  validates :team_member, presence: :true
end
