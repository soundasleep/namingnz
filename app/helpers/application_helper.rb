module ApplicationHelper
  def applicant_link(applicant)
    link_to(applicant.nickname, applicant_path(applicant))
  end

  def team_member_link(team_member)
    link_to(team_member.name, team_member_path(team_member))
  end

  def user_link(user)
    link_to("#{user.name} (#{user.provider})", user_path(user))
  end
end
