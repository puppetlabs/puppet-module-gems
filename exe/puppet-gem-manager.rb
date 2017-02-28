#!/usr/bin/env ruby

require_relative '../lib/puppet-gem-manager.rb'
include PuppetGemManager::Constants

info = PuppetGemManager::InfoParser.get_info(INFO_FILE)
matrix = PuppetGemManager::DependenciesParser.build_gem_matrix(DEPENDENCIES_FILE)
matrix.keys.each do |gem|
  # This should be a config hash that gets passed into the renderer
  gemspec = {}
  gemspec['name'] = "#{info['prefix']}-#{gem}"
  gemspec['info'] = info
  gemspec['dependencies'] = matrix[gem]

  PuppetGemManager::GemspecRenderer.generate_gemspec(gemspec, TEMPLATE_FILE, PKG_PATH)
  PuppetGemManager::GemBuilder.build_all_gems(PKG_PATH)
end

