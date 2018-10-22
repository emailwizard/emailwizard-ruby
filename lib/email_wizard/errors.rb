module EmailWizard
  class DeliveryFailureError < StandardError; end
  class NoConfigError < StandardError; end
  class ProjectUnknownError < StandardError; end  
end