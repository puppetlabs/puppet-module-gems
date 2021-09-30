#!/usr/bin/env ruby

require_relative '../lib/puppet-module-gems/constants.rb'
include PuppetModuleGems::Constants

Dir["#{PKG_PATH}/*.gem"].sort.each do |file|
  gem = File.basename(file).split('.gem').first
  gem_version = gem.split('-').last
  gem_name = gem.split("-#{gem_version}").first

  puts "## Pushing #{gem_name} to https://rubygems.org."
  value = `gem push #{file}`
  puts value
end
