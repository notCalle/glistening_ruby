# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'glistening_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'glistening_ruby'
  spec.version       = GlisteningRuby::VERSION
  spec.authors       = ['Calle Englund']
  spec.email         = ['calle@discord.bofh.se']

  spec.summary       = 'A Project Template Default Summary'
  spec.homepage      = 'https://github.com/notcalle/__PROJECT_TEMPLATE_SNAME__'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '~> 3.0'

  spec.add_dependency 'perlin', '~> 0.2.2'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'cucumber', '~> 3.1'
  spec.add_development_dependency 'git-version-bump', '~> 0.15'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.57'
  spec.add_development_dependency 'ruby-prof', '~> 0.17'
  spec.add_development_dependency 'simplecov', '~> 0.16'
end
