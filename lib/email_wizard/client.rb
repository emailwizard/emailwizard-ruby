require 'net/http'
require 'uri'

module EmailWizard
  # Main class for sending mails
  class Client
    API_URI = 'https://api.emailwizard.io/api/v1/projects/'.freeze

    attr_accessor :config

    attr_accessor :current_project_id

    def configured?
      raise EmailWizard::NoConfigError if @config.nil?
    end

    def self.send_template; end

    def fetch_template(project_id: nil, template_name:, payload:)
      post(project_id,
           'templates/fetch',
           template_name: template_name,
           payload: payload)
    end

    def build_uri(project_id, action)
      project_id ||= @current_project_id
      raise EmailWizard::ProjectUnknownError if project_id.nil?

      URI.join(API_URI, project_id.to_s + '/', action)
    end

    def post(project_id, action, data)
      configured?
      uri = build_uri(project_id, action)
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end
      JSON.parse(res)
    end
  end
end
