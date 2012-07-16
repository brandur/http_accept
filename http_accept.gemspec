Gem::Specification.new do |gem|
  gem.name        = "http_accept"
  gem.version     = "0.1.1"

  gem.author      = "Brandur"
  gem.email       = "brandur@mutelight.org"
  gem.homepage    = "https://github.com/brandur/http_accept"
  gem.license     = "MIT"
  gem.summary     = "Simple library for HTTP Accept header parsing and ordering."

  gem.files       = %w( README.md Rakefile )
  gem.files       += Dir["lib/**/*"]
end
