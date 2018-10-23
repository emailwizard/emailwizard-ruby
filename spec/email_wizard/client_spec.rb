RSpec.describe EmailWizard::Client do
  it "raises error if not cofigured" do
    expect{EmailWizard::Client.configured?}.to raise_error(EmailWizard::NoConfigError)
  end
end
