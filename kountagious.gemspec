Gem::Specification.new do |s|
  s.name        = 'kountagious'
  s.version     = '0.0.0'
  s.date        = '2016-07-14'
  s.summary     = "Simple wrapper for kounta api"
  s.description = "A very simple and incomplete wrapper for the kounta api"
  s.authors     = ["Kewan Shunn"]
  s.email       = 'kewan@kewanshunn.com'
  s.files       = ["lib/kountagious.rb"]
  s.homepage    =
    'https://github.com/kewan/kountagious'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "rake", "~> 11.2"
  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "webmock", "2.1"

  s.add_dependency "oauth2", "~> 1.2"
  s.add_dependency "faraday_middleware", "~> 0.10"
end
