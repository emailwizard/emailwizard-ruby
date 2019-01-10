RSpec.describe EmailWizard::Config do
  it 'returns config hash' do
    config = EmailWizard::Config.new(
      api_key: 1,
      provider: :sendgrid,
      provider_credentials: {
        api_key: 2
      },
      from: 'no-reply@example.org'
    )

    expect(config.as_hash).to eq(
      from: 'no-reply@example.org',
      'sendgrid_credentials' => { api_key: 2 }
    )
  end
end
