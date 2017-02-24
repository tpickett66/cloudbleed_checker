# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloudbleed_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "cloudbleed_checker"
  spec.version       = CloudbleedChecker::VERSION
  spec.authors       = ["Tyler Pickett"]
  spec.email         = ["t.pickett66@gmail.com"]

  spec.summary       = %q{A utility to check your browser history for cloudflare hosted sites}
  spec.description   = %q{A utility to check your browser history for cloudflare hosted sites}
  spec.homepage      = "https://github.com/tpickett66/cloudbleed_checker"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.14"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "sequel", "~> 4.43"
  spec.add_dependency "sqlite3", "~> 1.3"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
