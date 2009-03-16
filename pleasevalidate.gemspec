# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pleasevalidate}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dylan Fogarty-MacDonald"]
  s.date = %q{2009-03-16}
  s.default_executable = %q{pleasevalidate}
  s.description = %q{A little markup validator.}
  s.email = ["dylan.fm@gmail.com"]
  s.executables = ["pleasevalidate"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "LICENSE", "Manifest.txt", "PostInstall.txt", "README.rdoc", "RakeFile", "bin/pleasevalidate", "cucumber.yml", "features/cli_validation.feature", "features/file_types.feature", "features/steps/cli_validation_steps.rb", "features/steps/file_types_steps.rb", "features/steps/helper.rb", "features/steps/validate_multiple_files_steps.rb", "features/steps/validate_steps.rb", "features/validate.feature", "features/validate_multiple_files.feature", "lib/please_validate.rb", "lib/please_validate/cli.rb", "lib/please_validate/validator.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/DylanFM/please_validate/tree}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pleasevalidate}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A little markup validator.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<colored>, [">= 0"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<colored>, [">= 0"])
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<colored>, [">= 0"])
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
