#!/usr/bin/env ruby

require_relative '../lib/puppet-module-gems/constants.rb'
include PuppetModuleGems::Constants

OWNERS = [
"carabas.milan@gmail.com",
"ciaran.mccrisken@puppet.com",
"david.schmitt@puppet.com",
"david.swan@puppet.com",
"loredana.ionce@puppet.com",
"michael.t.lombardi@gmail.com",
"morgan@puppetlabs.com",
"paula@puppet.com",
"sheena@puppet.com",
"tp@puppet.com",
]

Dir["#{PKG_PATH}/*.gem"].sort.each do |file|
  gem = File.basename(file).split('.gem').first
  gem_version = gem.split('-').last
  gem_name = gem.split("-#{gem_version}").first

  puts "Obtaining current owner list for #{gem_name}"
  current_owners = `gem owner #{gem_name}`.scan(%r{-\s(\S+)}).flatten

  owners_to_remove = current_owners - OWNERS
  unless owners_to_remove.empty?
    puts "Removing the following owners #{owners_to_remove}"
    owners_to_remove.each do |owner|
      value = `gem owner --remove #{owner} #{gem_name}`
      puts value
    end
  end

  owners_to_add = OWNERS - current_owners
  unless owners_to_add.empty?
    puts "Adding the following owners #{owners_to_add}"
    owners_to_add.each do |owner|
      value = `gem owner --add #{owner} #{gem_name}`
      puts value
    end
  end

  puts "## Pushing #{gem_name} to https://rubygems.org."
  value = `gem push #{file}`
  puts value
end
