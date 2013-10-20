$:.push File.expand_path("../lib", __FILE__)
require 'vagrant-recipe/version'

Gem::Specification.new do |s|
  s.name        = 'vagrant-recipe'
  s.version     = VagrantPlugins::Recipe::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Raul Simiciuc'
  s.email       = 'byraul@gmail.com'
  s.homepage    = 'http://github.com/rsimiciuc/vagrant-recipe'
  s.summary     = 'Execute chef recipes'
  s.description = 'Vagrant plugin to execute chef recipes'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)

  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rake'
end
