class Vote < ActiveRecord::Base
  YES = "yes"
  NO = "no"
  ABSTAIN = "abstain"
  ABSENT = "absent"

  VALID_VOTES = [YES, NO, ABSTAIN, ABSENT]

  belongs_to :application
  belongs_to :team_member

  validates :application, presence: true
  validates :team_member, presence: true
end
