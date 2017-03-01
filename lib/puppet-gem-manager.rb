lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'puppet-gem-manager/constants'
require 'puppet-gem-manager/info_parser'
require 'puppet-gem-manager/dependencies_parser'
require 'puppet-gem-manager/gemspec_renderer'
require 'puppet-gem-manager/gem_builder'

module PuppetGemManager
  # Empty stub for now. Will include CLI features and more customization
  # features in the future.
end
