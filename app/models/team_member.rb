class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :promoted_by, class_name: "User"

  has_many :applicants, dependent: :nullify
  has_many :applications, dependent: :nullify
  has_many :votes, dependent: :destroy

  validates :name, presence: :true
  validates :email, presence: :true
  validates :phone, presence: :true
  validates :user, presence: :true

  def to_s
    "#{name} (#{email})"
  end
end
