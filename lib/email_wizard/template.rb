require 'base64'

module EmailWizard
  # Rendered template
  class Template
    attr_reader :html
    attr_reader :text

    def initialize(html:, text:)
      @html = html
      @text = text
    end

    def self.from_json(json)
      puts(json)
      Template.new(
        html: Base64.decode64(json[:html]),
        text: Base64.decode64(json[:text])
      )
    end
  end
end
