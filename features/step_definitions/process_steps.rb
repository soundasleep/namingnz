def new_applicant
  @new_applicant ||= Applicant.create! nickname: "Applicant"
end

Given(/^there is an applicant assigned to me$/) do
  AssignApplicantToTeamMember.new(team_member: new_team_member, applicant: new_applicant).call
end

Given(/^the applicant has applied for a (.+)$/) do |category|
  new_applicant.applications.create! category: category
end
