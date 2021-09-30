#!/usr/bin/env ruby

# This script will:
# - Query the owners of each Puppet Module Gems gem
# - Compare the owners of each gem to the expectation defined in OWNERS
# - Generate a list of owners that should be removed
# - Generate a list of owners that should be added
# - Request confirmation for the add / remove operation
# - Execute the add / remove operation using `gem owner`

require_relative '../lib/puppet-module-gems/constants.rb'
include PuppetModuleGems::Constants

# Add / remove owners here
OWNERS = [
    "michaeltlombardi",
    "sheenaajay",
    "sanfrancrisko",
    "lionce",
    "underscorgan",
    "davidswan",
    "pmcmaw",
    "ia-content",
    "davea",
]

gem_owners_to_remove = {}
gem_owners_to_add = {}

Dir["#{PKG_PATH}/*.gem"].sort.each do |file|
    gem = File.basename(file).split('.gem').first
    gem_version = gem.split('-').last
    gem_name = gem.split("-#{gem_version}").first

    puts "Obtaining current owner list for #{gem_name}"
    current_owners = `gem owner #{gem_name}`.scan(%r{-\s(\S+)}).flatten

    current_owners.each do |current_owner|
        gem_owners_to_remove[gem_name] = [] unless gem_owners_to_remove.key? gem_name
        gem_owners_to_remove[gem_name] << current_owner unless OWNERS.include? current_owner
    end

    OWNERS.each do |owner|
        gem_owners_to_add[gem_name] = [] unless gem_owners_to_add.key? gem_name
        gem_owners_to_add[gem_name] << owner unless current_owners.include? owner
    end
end

puts "\n\nThe following REMOVE operations will be performed:\n"

gem_owners_to_remove.each do |gem, gem_owners_to_remove|
    puts "#{gem}:"
    gem_owners_to_remove.each do |owner_to_remove|
        puts "- #{owner_to_remove}"
    end
end

print "\n Does this look correct? [Y/N] "
prompt = gets.chomp.downcase

if prompt == "y"
    puts ""
    gem_owners_to_remove.each do |gem, owners_to_remove|
        owners_to_remove.each do |owner_to_remove|
            result=`gem owner --remove #{owner_to_remove} #{gem}`
            puts result
        end
    end
elsif prompt == "n"
    puts "\nPlease correct 'OWNERS' list in script and re-run"
    exit 1
else 
    puts "\nInvalid option"
    exit 1
end

puts "\n\nThe following ADD operations will be performed:\n"

gem_owners_to_add.each do |gem, owners_to_add|
    puts "#{gem}"
    owners_to_add.each do |owner_to_add|
        puts "- #{owner_to_add}"
    end
end

print "\n Does this look correct? [Y/N] "
prompt = gets.chomp.downcase

if prompt == "y"
    puts ""
    gem_owners_to_add.each do |gem, owners_to_add|
        owners_to_add.each do |owner_to_add|
            result=`gem owner --add #{owner_to_add} #{gem}`
            puts result
        end
    end
elsif prompt == "n"
    puts "\nPlease correct 'OWNERS' list in script and re-run"
    exit 1
else 
    puts "\nInvalid option"
    exit 1
end
