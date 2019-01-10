RSpec.describe EmailWizard::Client do
  API_URI = 'https://api.emailwizard.io/api/v1/projects/'.freeze

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
    expect(uri.to_s).to eq(API_URI + '1/template/fetch')
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
    uri = client.send(:build_uri, 1, 'templates/fetch')
    expect(uri.to_s).to eq(API_URI + '1/templates/fetch')
  end

  it 'fetches template' do
    stub_request(:post, API_URI + '1/templates/fetch')
      .to_return(body: { html: '', text: '' }.to_json, status: 200)
    client = configured_client
    client.fetch_template(project_id: 1, template_name: 'test', payload: {})
  end

  it 'sets api-key header template' do
    stub_request(:post, /.*/)
      .with(headers: { 'Api-key' => 1 })
      .to_return(body: { html: '', text: '' }.to_json, status: 200)
    client = configured_client
    client.fetch_template(project_id: 1, template_name: 'test', payload: {})
  end

  it 'sends message' do
    stub_request(:post, API_URI + '1/templates/send')
      .with(body: {
              template_name: 'test',
              payload: {},
              subject: 'Test',
              recipients: ['user@example.com'],
              from: 'no-reply@example.org',
              'sendgrid_credentials' => { api_key: 2 }
            }).to_return(body: { html: '', text: '' }.to_json, status: 200)
    client = configured_client
    client.send_template(project_id: 1, template_name: 'test', subject: 'Test',
                         recipients: ['user@example.com'], payload: {})
  end
end
