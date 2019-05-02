Gem::Specification.new do |spec|
  spec.name = "roda-extras"
  spec.version = "0.1.0"
  spec.authors = ["Adam Daniels"]
  spec.email = "adam@mediadrive.ca"

  spec.summary = %q(A few extra goodies for Roda applications)
  spec.homepage = "https://github.com/adam12/roda-extras"
  spec.license = "MIT"

  spec.files = ["README.md"] + Dir["lib/**/*.rb"]

  spec.add_dependency "roda", ">= 3.19"
end
