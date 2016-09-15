def new_applicant
  @new_applicant ||= Applicant.create! nickname: "Applicant"
end

Given(/^there is an applicant assigned to me$/) do
  AssignApplicantToTeamMember.new(team_member: new_team_member, applicant: new_applicant).call
end

Given(/^the applicant has applied for a (.+)$/) do |category|
  @last_application = new_applicant.applications.create! category: category
end

Given(/^the applicant was sent a cheque (\d+) days ago$/) do |days|
  @last_application.cheques.create! amount: 100, payee: "A payee", team_member: new_team_member, created_at: days.to_i.days.ago
end

Given(/^cheques expire in (\d+) days$/) do |days|
  expect(NamingNZ.cheques_expire_in_days).to eq(days.to_i)
end
