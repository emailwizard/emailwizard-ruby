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
      configured?
      response = post(project_id,
                      'templates/fetch',
                      template_name: template_name,
                      payload: payload)
      Template.from_json(response)
    end

    def send_template(project_id: nil, template_name:, payload:,
                      subject:, recipients:, from: nil)
      configured?
      data = @config.as_hash.merge(
        template_name: template_name,
        payload: payload,
        subject: subject,
        recipients: recipients
      )
      data[:from] = from unless from.nil?
      response = post(project_id, 'templates/send', data)
      Message.from_json(response)
    end

    def build_uri(project_id, action)
      project_id ||= @current_project_id
      raise EmailWizard::ProjectUnknownError if project_id.nil?

      URI.join(API_URI, project_id.to_s + '/', action)
    end

    def post(project_id, action, data)
      uri = build_uri(project_id, action)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      req['Api-Key'] = @config.api_key
      req.body = data.to_json
      res = https.request(req)
      body = JSON.parse(res.body, symbolize_names: true)
      success?(res, body)

      body
    end

    private

    def success?(res, body)
      return true unless res.code.to_i > 299

      raise EmailWizard::DeliveryFailureError.new(errors: body[:errors])
    end
  end
end
