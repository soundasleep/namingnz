class TeamMember < ActiveRecord::Base
  belongs_to :user

  has_many :applicants, dependent: :nullify
end
