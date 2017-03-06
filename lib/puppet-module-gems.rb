lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'puppet-module-gems/constants'
require 'puppet-module-gems/info_parser'
require 'puppet-module-gems/dependencies_parser'
require 'puppet-module-gems/gemspec_renderer'
require 'puppet-module-gems/gem_builder'

module PuppetModuleGems
  # Empty stub for now. Will include CLI features and more customization
  # features in the future.
end
