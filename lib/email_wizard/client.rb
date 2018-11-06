require 'uri'

class EmailWizard::Client
  API_URI = 'https://api.emailwizard.io/api/v1/projects/'

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
  	response = post(project_id, 'templates/fetch', payload)
  end

  private

  def self.build_uri(project_id, action)
  	project_id = project_id || @@current_project_id
  	raise EmailWizard::ProjectUnknownError if project_id.nil?
  	
  	URI.join(API_URI, project_id.to_s, action)
  end

  def self.post(project_id, action, data)
  	configured?
  	uri = build_uri(project_id, action)
  end

end