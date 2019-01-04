module EmailWizard
  # Config the api and provider
  class Config
    def initialize(api_key:, provider:, provider_credentials:, from:)
      @api_key = api_key
      @provider = provider
      @provider_credentials = provider_credentials
      @from = from
    end
  end
end
