class EmailWizard::Client
  @@config = nil

  def self.configured?
    raise EmailWizard::NoConfigError if @@config.nil?
  end
end