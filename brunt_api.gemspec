
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "brunt_api/version"

Gem::Specification.new do |spec|
  spec.name          = "brunt_api"
  spec.version       = BruntAPI::VERSION
  spec.authors       = ["mmck328"]
  spec.email         = ["edamame1010@hotmail.co.jp"]

  spec.summary       = "An unofficial Ruby binding for Brunt API (e.g. Blind Engine)"
  spec.description   = "This is an unofficial Ruby binding of Brunt API (e.g. Blind Engine). Ported from JS binding by MattJeanes https://github.com/MattJeanes/brunt-api"
  spec.homepage      = "https://github.com/mmck328/brunt_api.rb"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "faraday", "~> 0.15.4"
  spec.add_dependency "faraday_middleware", "~> 0.12.2"
  spec.add_dependency "faraday-cookie_jar", "~> 0.0.6"
end
