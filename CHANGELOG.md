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
