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
