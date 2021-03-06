# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "./lib/diff_colorize/version"

Gem::Specification.new do |spec|
  spec.name          = "diff_colorize"
  spec.version       = DiffColorize::VERSION
  spec.authors       = ["Keisuke Ishizawa"]
  spec.email         = ["k_ishizawa@sfidante.co.jp"]

  spec.summary       = %q{Compare two text and decorate text differences.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/kei-p/diff_colorize"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"

  spec.add_dependency "diff-lcs", "~> 1.2"

end
