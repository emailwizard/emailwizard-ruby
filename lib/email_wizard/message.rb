module EmailWizard
  # Sent message
  class Message
    attr_reader :id
    attr_reader :messages

    def initialize(id:, messages:)
      @id = id
      @messages = messages
    end

    def self.from_json(json)
      Message.new(id: json[:message_id], messages: json[:messages])
    end
  end
end
