RSpec.describe EmailWizard::Config do
  it 'inits' do
    EmailWizard::Config.new(
      api_key: 1,
      provider: :sendgrid,
      provider_credentials: {
        api_key: 2
      },
      from: 'no-reply@example.org'
    )
  end
end
