lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_wizard/version'

Gem::Specification.new do |spec|
  spec.name          = 'email_wizard'
  spec.version       = EmailWizard::VERSION
  spec.authors       = ['Denys Potapov']
  spec.email         = ['denys.potapov@gmail.com']

  spec.summary       = 'Ruby integration for emailwizard'
  # spec.description   = %q{TODO: Write a longer description.}
  spec.homepage      = 'https://github.com/emailwizard/emailwizard-ruby'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    reject = %r{^(test|spec|features)/}
    `git ls-files -z`.split("\x0").reject { |f| f.match(reject) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.59.2'
  spec.add_development_dependency 'webmock', '~> 3.4.2'
end
