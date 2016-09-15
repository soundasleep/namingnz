class User < ActiveRecord::Base
  has_many :team_members, dependent: :destroy

  def to_s
    "#{name} (#{provider})"
  end

  def team_member?
    team_members.any?
  end
end
