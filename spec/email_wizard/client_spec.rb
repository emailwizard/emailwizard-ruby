RSpec.describe EmailWizard::Client do
  def configured_client()
  	EmailWizard::Client.config = EmailWizard::Config.new(
      api_key: 1,
      provider: :sendgrid,
      provider_credentials: {
        api_key: 2
      },
      from: 'no-reply@example.org'
    )
    EmailWizard::Client
  end

  it "raises error if not cofigured" do
    expect{EmailWizard::Client.configured?}.to raise_error(EmailWizard::NoConfigError)
  end

  it "uses default project id if note set" do
    client = configured_client
    client.current_project_id = 1
    client.fetch_template(template_name: 'test', payload: {})
  end

  it "throws an error if no project id" do
  	client = configured_client
    client.current_project_id = nil
    expect{client.fetch_template(template_name: 'test', payload: {})}.to raise_error(EmailWizard::ProjectUnknownError)
  end

end
