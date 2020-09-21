require_relative 'lib/family/tree/version'

Gem::Specification.new do |spec|
  spec.name          = "family-tree"
  spec.version       = Family::Tree::VERSION
  spec.authors       = ["pranava s balugari"]
  spec.email         = ["stalin.pranava@gmail.com"]

  spec.summary       = %q{Technical challenge to solve the family tree problem.}
  spec.description   = %q{Technical challenge to solve the family tree problem.}
  spec.homepage      = "https://github.com/elitenomad/family-tree"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elitenomad/family-tree"
  spec.metadata["changelog_uri"] = "https://github.com/elitenomad/family-tree"
  
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
