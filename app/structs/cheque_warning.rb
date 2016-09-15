class ChequeWarning
  attr_reader :cheque, :description

  delegate :applicant, :application, to: :cheque

  def initialize(cheque:, description:)
    @cheque = cheque
    @description = description
  end
end
