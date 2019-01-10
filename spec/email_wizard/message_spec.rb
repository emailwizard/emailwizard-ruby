RSpec.describe EmailWizard::Message do
  it 'creates from json' do
    message = EmailWizard::Message.from_json(
      message_id: 2,
      messages: ['message 1']
    )
    expect(message.id).to eq(2)
    expect(message.messages).to eq(['message 1'])
  end
end
