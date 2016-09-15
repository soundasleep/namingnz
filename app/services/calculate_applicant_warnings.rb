class CalculateApplicantWarnings
  attr_reader :applicant

  def initialize(applicant:)
    @applicant = applicant
  end

  def call
    warnings = []

    warnings += expiring_cheques
  end

  private

  def expiring_cheques
    applicant.applications.active.map(&:cheques).flatten.select do |cheque|
      cheque.active?
    end.select do |cheque|
      cheque.active_for_days >= (NamingNZ.cheques_expire_in_days / 2)
    end.map do |cheque|
      days_left = NamingNZ.cheques_expire_in_days - cheque.active_for_days

      ChequeWarning.new(
        cheque: cheque,
        description: "Applicant hasn't cashed in their cheque for their #{cheque.application.category}. Their cheque will expire in #{days_left} days",
      )
    end
  end
end
