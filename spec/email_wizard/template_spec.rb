RSpec.describe EmailWizard::Template do
  it 'creates from json' do
    template = EmailWizard::Template.from_json(
      html: 'PGh0bWwgLz4=',
      text: 'dGV4dA=='
    )
    expect(template.html).to eq('<html />')
    expect(template.text).to eq('text')
  end
end
