# frozen_string_literal: true

require_relative 'lib/notify_slack/version'

Gem::Specification.new do |spec|
  spec.name          = 'notify_slack'
  spec.version       = NotifySlack::VERSION
  spec.authors       = ['truecoach']
  spec.email         = ['developers@truecoach.co']

  spec.summary       = 'Simple gem for posting to slack webhooks'
  spec.homepage      = 'https://github.com/truecoach/notify_slack'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/truecoach/notify_slack'
  spec.metadata['changelog_uri'] = 'https://github.com/truecoach/notify_slack'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency('pry-byebug')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('webmock', '~> 3.5')
end
