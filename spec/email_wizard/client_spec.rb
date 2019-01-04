RSpec.describe EmailWizard::Client do
  def configured_client
    client = EmailWizard::Client.new
    client.config = EmailWizard::Config.new(
      api_key: 1,
      provider: :sendgrid,
      provider_credentials: {
        api_key: 2
      },
      from: 'no-reply@example.org'
    )
    client
  end

  it 'raises error if not cofigured' do
    expect { EmailWizard::Client.new.configured? }.to raise_error(
      EmailWizard::NoConfigError
    )
  end

  it 'uses default project id if note set' do
    client = configured_client
    client.current_project_id = 1
    uri = client.send(:build_uri, 1, 'template/fetch')
    expect(uri.to_s).to eq('https://api.emailwizard.io/api/v1/projects/1/template/fetch')
  end

  it 'throws an error if no project id' do
    client = configured_client
    client.current_project_id = nil
    expect do
      client.fetch_template(template_name: 'test', payload: {})
    end.to raise_error(EmailWizard::ProjectUnknownError)
  end

  it 'builds url' do
    client = configured_client
    uri = client.send(:build_uri, 1, 'template/fetch')
    expect(uri.to_s).to eq('https://api.emailwizard.io/api/v1/projects/1/template/fetch')
  end
end
