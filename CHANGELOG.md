## 1.0.1

- Relax `puppet_limtus` dependency range from ~> 0.21.0 to ~> 0.21

## 1.0.0

### Remove Ruby 2.1 & 2.3 dependencies
We no longer support these Ruby versions

### Move `puppet_litmus` to `system_tests`
With this we can remove the litmus dependency from unit tests - which historically has been causing dependency conflicts between `bolt`'s internals and the `puppet` gem under test. Instead [`pdk-templates`](https://github.com/puppetlabs/pdk-templates/pull/371) now installs `puppet_litmus` only when actually needed through the `system_tests` group.

This removes the unmaintained beaker dependencies from the gems. If you still require those, you can still use the previous `<1.0.0` gems. Please consider [upgrading](https://puppetlabs.github.io/litmus/Converting-modules-to-use-Litmus.html).

### Update to newest rubocop version
With the drop of old rubies we can update to the current version of rubocop. Together with the [change of policies](https://github.com/puppetlabs/pdk-templates/pull/371), there should be only very little changes required to your ruby code and `pdk validate -a` should fix the most annoying bits.
- Pins `rubocop` to 1.6.1
- Pins `rubocop-spec` to 2.0.1
- Add `rubocop-performance`

### Update tooling for ruby 2.4+
- Pull `puppet-debugger` into main section
- Pull `puppet-blacksmith` into main section
- Relax `codecov` pin
- Update `parallel_tests` pin to latest version
- Update `puppet-syntax` pin to latest version

### Remove i18n related tooling
- `gettext-setup`
- `puppet_pot_generator`
- `rubocop-i18n`

### Other cleanup
- allow newer versions of `metadata-json-lint`
- add `rb-readline` pin for windows (formerly in pdk-template's default config's Gemfile)
- remove activesupport pin where not needed

## 0.5.3

- Remove `rspec-expectations` after `rspec-puppet` 2.8.0 release
- Allow installing rspec-puppet-facts v2
- Pin `parallel` on rubies prior to 2.5 to the last version supporting that ruby

## 0.5.2

- Update `puppet-debugger` gem to 1.0 for ruby 2.4+
- Pin `rspec-expectations` to `< 3.10.0` until https://github.com/rodjek/rspec-puppet/pull/811 is released

## 0.5.1

- Pin `simplecov` to `< 0.19.0` on Ruby `2.4` as `0.19.0` requires Ruby `>= 2.5`
- Pin `simplecov` to `< 0.19.0` on Ruby `2.5`, `2.6` and `2.7` as `0.19.0` was causing build hangs on TravisCI
- Pin `codecov` to `>= 0.2, < 0.2.6` as all versions prior to `0.2` were yanked and `0.2.5` is the latest version
supported on all Ruby versions.

## 0.5.0

- Add Ruby 2.7 support
- General refresh of depedencies for easier future maintenance (see #130 for the gory details)

## 0.4.4

- Avoid concurrent-ruby 1.1.6 which is triggering MRI segfaults

## 0.4.3

- Update version range for facterdb to '>= 0.8.1', '< 2.0.0'
- Bump of rspec-puppet-facts to ~> 1.10.0
- Bump of specinfra version to support EL8
- Add puppet-debugger to development gems

## 0.4.2

- Add net-ssh to ruby 2.1 for system tests
- Add activesupport to ruby 2.3 for github-changelog-generator

## 0.4.1

- Only include puppet_litmus on Ruby 2.5 and Ruby 2.6
- Bump FacterDB and rspec-puppet-facts versions

## 0.4.0

- Add puppet-resource_api to default gems
- Add puppet_litmus to development gems
- Add build configuration for Ruby 2.6

## 0.3.15

- Add dependency_checker gem
- Bump of slecinfra version, to include fixes for checking password info on SLES 11 and Solaris 11

## 0.3.14

- Bump of specinfra version, to include fix for checking service status on SLES 15.

## 0.3.13

- Bump of specinfra version, for compatibility with SLES 15.

## 0.3.12

- Bump version beaker-puppet, for puppet 6 compatibility.

## 0.3.11

- Pin beaker-puppet explicitly.

## 0.3.10

- Pin to beaker 4, (and helper gems) for system tests on all platforms.

## 0.3.9

- Pin to beaker 3, (and helper gems) for system tests on all platforms.

## 0.3.8

- Pin fog-openstack for Ruby 2.1 on all platforms.

## 0.3.7

- Extend net-telnet pin for Ruby 2.1 on all platforms.

## 0.3.6

- Add net-telnet pin for Ruby 2.1 on Windows.

## 0.3.5

- Add codecov and simplecov-console to the default gems.
- Bump puppetlabs_spec_helper to 2.9.0 to get the coverage functionality

## 0.3.4

- Update pin of puppetlabs\_spec\_helper to require fixes to fixtures cleanup.
- Adds puppet-strings.

## 0.3.3

- Adds puppet-blacksmith to the development group for non-windows platforms.

## 0.3.2

- Removes unneeded windows pins that were there to support < 4.5 versions of Puppet.
- Updates the puppetlabs\_spec\_helper gem pin to support the mock framework defaulting.

## 0.3.1

- Removes ffi pins.

## 0.3.0

- Adds ruby 2.5 to the config build matrix.

## 0.2.5

- Pins ffi gem to 1.9.18 to avoid various compile errors in both windows and linux on 1.9.21.
- Removes stickler from gem publish script.

## 0.2.4

- Adjusts Rubocop dependency pins to fix dependency resolution issues

## 0.2.3

- Tighten rubocop version pins

## 0.2.2

- Loosen the pin on rainbow

## 0.2.1

- Removes `puppet-lint-i18n` from managed dependencies.

## 0.2.0

- Adds gems needed for i18n development and testing.
- Updates to build and publish scripts to push to stickler.
- Adds new owners.

## 0.1.1

- Raise minimum version requirement of `puppetlabs_spec_helper`.
- Lower maximum version allowed for `parallel_tests`.

## 0.1.0

- Increases `puppetlabs_spec_helper` minimum version.
- Increases `metadata-json-lint` minimum version.
- Adds example of using gems to build shared Docker images

## 0.0.10

- Updates the puppetlabs\_spec\_helper version range.

## 0.0.9

- Removes puppet-blacksmith from managed dependencies.
- Adds gettext-setup to shared dependencies management.
- Adds Upper and lower bounds to version pins to avoid crossing major versions.

## 0.0.8

- Adds metadata-json-lint to shared (Posix/Windows).
- Adds rspec-puppet-facts to shared (Posix/Windows).
- Removes puppet\_facts.

## 0.0.7

- Adds rubocop-rspec as a dependency for all platforms

## 0.0.6

- Pins Nokogiri on Windows and Ruby < 2.2

## 0.0.5

- Add ruby 2.4

## 0.0.4

- Adds rspec\_junit\_formatter ~> 0.2 as a shared dev dependency

## 0.0.3

- Pins specinfra to 2.67.3

## 0.0.2

### Bugfixes

- Moved the static analysis gems that were in shared to posix, since those gems have an additional ruby (devkit) requirement on Windows.

## 0.0.1

This is the initial release of the project.
