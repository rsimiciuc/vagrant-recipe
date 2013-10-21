vagrant-recipe [![Gem Version](https://badge.fury.io/rb/vagrant-recipe.png)](http://badge.fury.io/rb/vagrant-recipe)
===============

Vagrant plugin to execute chef recipes.

Description
-----------

Use this plugin to run your recipes at any time.

Example
-------

```shell
➜ vagrant run-recipe SystemSetup::default
```

Installation
------------

```shell
➜ vagrant plugin install vagrant-recipe
```

Configuration
-------------

### Chef exec file and chef json config file

The root directory can be configured using Vagrantfile.

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'precise32'
  # set this value if your solo exec file is different from /tmp/vagrant-chef-1/solo.rb
  config.recipe.chef = '/tmp/vagrant-chef-1/solo.rb'
  
  # set this value if your json confi file is different from /tmp/vagrant-chef-1/dna.json
  config.recipe.json = '/tmp/vagrant-chef-1/dna.json'
end
```

```shell
➜ vagrant run-recipe SystemSetup
# is the same as
➜ vagrant ssh -c "sudo chef-solo -c /tmp/vagrant-chef-1/solo.rb -j /tmp/vagrant-chef-1/dna.json --override-runlist \"recipe[SystemSetup::default]\""
```

### Bundler

You can enable bundler to prepend each command with `bundle exec`. Note that it won't be done for commands starting with `bundle` (e.g. `bundle install`).

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'precise32'
  config.recipe.bundler = true
end
```

```shell
➜ vagrant recipe SystemSetup
# is the same as
➜ vagrant ssh -c "cd /vagrant && bundle exec sudo chef-solo -c /tmp/vagrant-chef-1/solo.rb -j /tmp/vagrant-chef-1/dna.json --override-runlist \"recipe[SystemSetup::default]\""
```

### Environment variables

You can add environment variables to be exported before.

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'precise32'
  config.recipe.env['RAILS_ENV'] = 'test'
  config.recipe.env['RAILS_ROOT'] = '/vagrant'
end
```

```shell
➜ vagrant exec SystemSetup
# is the same as
➜ vagrant ssh -c "export RAILS_ENV=test && export RAILS_ROOT=/vagrant && sudo chef-solo -c /tmp/vagrant-chef-1/solo.rb -j /tmp/vagrant-chef-1/dna.json --override-runlist \"recipe[SystemSetup::default]\""
```

Copyright
---------

Copyright (c) 2013-2013 Raul Simiciuc. See LICENSE.md for details.
