module ApplicationHelper
  def applicant_link(applicant)
    link_to(applicant.nickname, applicant_path(applicant))
  end

  def application_link(application)
    link_to("#{application.category}", applicant_application_path(application.applicant, application))
  end

  def team_member_link(team_member)
    if team_member.present?
      link_to(team_member.name, team_member_path(team_member))
    else
      content_tag "i", "nobody"
    end
  end

  def user_link(user)
    link_to("#{user.name} (#{user.provider})", user_path(user))
  end

  def applicant_status_link(applicant_status)
    if applicant_status.present?
      applicant_status.status
    else
      content_tag "i", "-"
    end
  end

  def application_status_link(application_status)
    if application_status.present?
      application_status.status
    else
      content_tag "i", "-"
    end
  end
end
