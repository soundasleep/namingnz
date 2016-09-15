class User < ActiveRecord::Base
  has_many :team_members, dependent: :destroy
end
