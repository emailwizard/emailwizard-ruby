module EmailWizard
  class NoConfigError < StandardError; end
  class ProjectUnknownError < StandardError; end
  # Delivery failure details
  class DeliveryFailureError < StandardError
    attr_reader :errors

    def initialize(msg = 'Delivery failed', errors:)
      @errors = errors
      super(msg)
    end
  end
end
