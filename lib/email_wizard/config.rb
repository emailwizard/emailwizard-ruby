module EmailWizard
  # Config the api and provider
  class Config
    attr_reader :api_key

    def initialize(api_key:, provider:, provider_credentials:, from:)
      @api_key = api_key
      @provider = provider
      @provider_credentials = provider_credentials
      @from = from
    end

    def as_hash
      {
        from: @from,
        @provider.to_s + '_credentials' => @provider_credentials
      }
    end
  end
end
