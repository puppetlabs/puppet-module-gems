#!/usr/bin/env ruby

require_relative '../lib/puppet-module-gems.rb'
include PuppetModuleGems::Constants

info = PuppetModuleGems::InfoParser.get_info(INFO_FILE)
matrix = PuppetModuleGems::DependenciesParser.build_gem_matrix(DEPENDENCIES_FILE)
matrix.keys.each do |gem|
  # This should be a config hash that gets passed into the renderer
  gemspec = {}
  gemspec['name'] = "#{info['prefix']}-#{gem}"
  gemspec['info'] = info
  gemspec['dependencies'] = matrix[gem]

  PuppetModuleGems::GemspecRenderer.generate_gemspec(gemspec, TEMPLATE_FILE, PKG_PATH)
  PuppetModuleGems::GemBuilder.build_all_gems(PKG_PATH)
end

