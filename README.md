# Puppet Module Gems

#### Table of Contents

1. [Description - What this utility does and why it is useful](#description)
2. [Setup - The basics of getting started with Puppet Module Gems](#setup)
    * [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Support](#support)

## Description

Puppet Module Gems is a utility that generates gemspecs and builds management gems based on a YAML-based configuration. The purpose for these gems is to reduce the amount of changes required to sync shared dependencies across multiple modules’ Gemfiles.

For example, when a dependency gem publishes a new release that requires Ruby 2.3.3, this would normally break all modules that install this gem that run on a version of Ruby less than 2.3.3. To fix this previously, you would need a modulesync to pin the gem to a compatible version. With these new gem management gems, you can instead update the gem version pin in a configuration YAML. The gem management will then build and publish to rubygems, and a bundle update fixes all affected modules.

## Setup

### Setup Requirements

* Requires Ruby version 2.0 or greater
* Requires RubyGems gem version 2.0 or greater
* Requires Bundler gem version 1.3.0 or greater

## Usage

To get started using this utility, first clone this git repository:

`git clone git@github.com:puppetlabs/puppet-module-gems.git`

Install the development gems:

`bundle install`

### Building the gems

To build the gems with the default configuration, execute the script `bundle exec exe/build-gems.rb`. The gemspec files and gems will be generated in the `pkg` directory. Use the `push-gems.rb` from the same location to push to rubygems.org, if you are a maintainer.

### Customizing dependency gems

To build customized dependency gems, you simply need to modify the config yamls prior to running the script.

First modify the `config/info.yml` to customize the prefix for your gem names, in addition to the rest of the required information. Secondly, you will need to modify the `config/dependencies.yml` to customize the dependency matrix to suit your needs. After defining these customizations, you can build your gems with the directions detailed in [Building the gems](#building-the-gems).

### Using generated gems

To use the resulting gems, replace the sections of the Module Gemfile with the appropriate gems and conditions.

For Example:

```ruby
group :development do
  gem 'puppet-lint',                        :require => false
  gem 'metadata-json-lint',                 :require => false, :platforms => 'ruby'
  gem 'puppet_facts',                       :require => false
  gem 'puppet-blacksmith', '>= 3.4.0',      :require => false, :platforms => 'ruby'
  gem 'puppetlabs_spec_helper', '>= 1.2.1', :require => false
  gem 'rspec-puppet', '>= 2.3.2',           :require => false
  gem 'rspec-puppet-facts',                 :require => false, :platforms => 'ruby'
  gem 'mocha', '< 1.2.0',                   :require => false
  gem 'simplecov',                          :require => false, :platforms => 'ruby'
  gem 'rubocop',                            :require => false
  gem 'pry',                                :require => false
  gem 'rainbow', '< 2.2.0',                 :require => false
end

group :system_tests do
  gem 'beaker-puppet_install_helper',                                            :require => false
  gem 'beaker-module_install_helper',                                            :require => false
  gem 'master_manipulator',                                                      :require => false
end
```

The above Gemfile section would become:

```ruby
# calculate the correct package names from the current ruby version
ruby_version_segments = Gem::Version.new(RUBY_VERSION.dup).segments
minor_version = "#{ruby_version_segments[0]}.#{ruby_version_segments[1]}"

gem "puppet-module-posix-default-r#{minor_version}"

group :development do
  gem "puppet-module-posix-dev-r#{minor_version}"
end

group :system_tests do
  gem "puppet-module-posix-system-r#{minor_version}"
end
```

After this update, the subsequent `bundle install` or `bundle update` would pull in the new gems and the dependencies should reflect the correct version bindings based on the Ruby version. Any future gems and version pinning that may be needed can be done via publishing updated management gems.

## Reference

### Configuration Files

#### info.yml

**Reserved Keys**

 * `info` - Details the start of the information block. Required.
 * `prefix` - Indicates the prefix to use for the generated gems. Required.

**Required Keys**

 * `authors` - String. The author of these gems.
 * `email` - String. Email address of the author.
 * `homepage` - String. Homepage for the gem project.
 * `licenses` - String. License to publish gems under.
 * `summary` - String. Brief description of what the gem does.
 * `version` - String. Version of these gems.

#### dependencies.yml

**Reserved Keys**

 * `dependencies` - Details the start of the dependencies block. Required.
 * `shared` - Details the shared dependencies amongst the keys within the same tier.
 * `gem` - Details the name of the gem dependency to add. Required.
 * `version` - Details the version bindings for the gem listed in preceding `gem`.

**Example**

```YAML
dependencies:
  shared:
    a:
      - gem: shared-gem
        version: '> 1.0.0'
  first:
    a:
      - gem: a-gem-one
    b:
      - gem: b-gem-one
        version: '< 2.0.0'
  second:
    b:
      - gem: b-gem-two
```

The above dependency matrix will generate this list of gems if the defined prefix is `test-gem` with version `1.0.0`:

- test-gem-first-a-1.0.0.gem
- test-gem-first-b-1.0.0.gem
- test-gem-second-a-1.0.0.gem
- test-gem-second-b-1.0.0.gem

And for example, the gemspec for `test-gem-first-a-1.0.0.gem` will include dependencies of:

- shared-gem, '> 1.0.0'
- a-gem-one

**Note:** To add a version range to a dependency, simply put the lower and upper bindings in an array:

``` YAML
- gem: gem-name
  version: ['>= 1.0.0', '< 2.0.0']
```

## Release Process

- From a clean checkout of master, create a release prep branch.
- Update `config/info.yml` with the new version.
- Update `CHANGELOG.md`.
- PR the release prep.
- Once PR is merged, checkout a clean copy of master.
- Run `bundle exec exe/build-gems.rb` to build the gems into the `pkg` directory.
- Validate that the gems have build correctly.
**The next step requires that you have Ownership permissions for these gems on rubygems.org, also requires access to internal Puppet network.**
- Run `bundle exec exe/push-gems.rb` to update owners and publish to rubygems.org.
- Tag the version and push tags to github.
  - e.g. `git tag -a 0.1.2 -m "0.1.2"`
  - e.g. `git push upstream --tags`

## Testing Changes

- Check out a clean copy from master.
- Run `bundle exec exe/build-gems.rb` to build the gems into the `pkg` directory.
- Confirm `pkg` directory contains a variety of `.gem` and .`gemspec` files.
- Locate a module that is making use of puppet-module-gems.
- Edit the Gemfile and point the gems to the local copy of your gems.

**Example**
```ruby
group :development do
  gem "puppet-module-posix-default-r#{minor_version}",    :require => false, :platforms => "ruby", :path => '/Users/paula/workspace/puppet-module-gems/pkg/'
  gem "puppet-module-win-default-r#{minor_version}",      :require => false, :platforms => ["mswin", "mingw", "x64_mingw"], :path => '/Users/paula/workspace/puppet-module-gems/pkg/'
  gem "puppet-module-posix-dev-r#{minor_version}",        :require => false, :platforms => "ruby", :path => '/Users/paula/workspace/puppet-module-gems/pkg/'
  gem "puppet-module-win-dev-r#{minor_version}", '0.0.7', :require => false, :platforms => ["mswin", "mingw", "x64_mingw"], :path => '/Users/paula/workspace/puppet-module-gems/pkg/'
  gem "json_pure", '<= 2.0.1',                            :require => false if Gem::Version.new(RUBY_VERSION.dup) < Gem::Version.new('2.0.0')
  gem "fast_gettext", '1.1.0',                            :require => false if Gem::Version.new(RUBY_VERSION.dup) < Gem::Version.new('2.1.0')
  gem "fast_gettext",                                     :require => false if Gem::Version.new(RUBY_VERSION.dup) >= Gem::Version.new('2.1.0')
end
```
- Ensure the Gemfile is generated as expected by running `bundle install --path .bundle/gems/`

## Limitations

Use of this utility has only been tested on Linux and OS-X platforms.


## Support

This utility is maintained and developed by the Puppet SDK and Puppet Modules team. Please file an [issue](https://github.com/puppetlabs/puppet-module-gems/issues) for support. [Contributions](https://github.com/puppetlabs/puppet-module-gems/blob/master/CONTRIBUTING.md) are also welcomed!
