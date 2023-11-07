# frozen_string_literal: true

require_relative "lib/numeral/version"

Gem::Specification.new do |spec|
  spec.name = "numeral"
  spec.version = Numeral::VERSION
  spec.authors = ["Xabi"]
  spec.email = ["xabi.aycaguer@gmail.com"]

  spec.summary = "Ruby SDK for Numeral API"
  spec.description = "Ruby SDK for Numeral API"
  spec.homepage = "https://github.com/MIPISE/numeral"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.1"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "rake"
end
