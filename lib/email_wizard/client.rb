class EmailWizard::Client
  @@config = nil

  @@current_project_id = nil

  def self.config=(config)
  	@@config = config
  end

  def self.current_project_id=(project_id)
  	@@current_project_id = project_id
  end

  def self.configured?
    raise EmailWizard::NoConfigError if @@config.nil?
  end

  def self.send_template()
  end

  def self.fetch_template(project_id: nil, template_name:, payload:)
  	response = post(project_id, :fetch, payload)
  end

  private

  def self.post(project_id, action, data)
  	configured?
  	project_id = project_id || @@current_project_id
  	raise EmailWizard::ProjectUnknownError if project_id.nil?
  end

end