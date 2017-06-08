#!/usr/bin/env ruby

require_relative '../lib/puppet-module-gems/constants.rb'
include PuppetModuleGems::Constants

OWNERS = [ 
"morgan@puppetlabs.com",
"bradejr@puppetlabs.com",
"stahnma@puppetlabs.com",
"melissa@puppetlabs.com",
"bryan.jen@puppet.com",
"david.schmitt@puppet.com",
"hunter@puppet.com"
]

Dir["#{PKG_PATH}/*.gemspec"].each do |file|
  gem_path = file.split('.gemspec')[0]
  gem_name = File.basename(file).split('.gemspec')[0]

  OWNERS.each do |owner|
    value = `gem owner --add #{owner} #{gem_name}`
    puts value
  end

  gem = Dir["#{gem_path}*.gem"].join(" ")
  value = `gem push #{gem}`
  puts value
end
