# frozen_string_literal: true

require_relative "lib/bnetd/version"

Gem::Specification.new do |spec|
  spec.name = "bnetd"
  spec.version = Bnetd::VERSION
  spec.authors = ["thynkon"]
  spec.email = ["thynkon@protonmail.com"]

  spec.summary = "A simple ruby script that parses ssh and http packets"
  spec.description = "This is a ruby script that fetches ssh and http packet's size and insert then into a mongodb database. Then, I will be able to perform some stats on that data."
  spec.homepage = "https://github.com/Thynkon/bnetd-db"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Thynkon/bnetd-db"
  #  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_dependency "concurrent-ruby"
  spec.add_dependency "mongo"
  spec.add_dependency "packetgen"
  spec.add_dependency "zeitwerk"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
