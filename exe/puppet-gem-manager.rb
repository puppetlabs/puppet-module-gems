require 'erb'
require 'fileutils'
require_relative '../lib/puppet-gem-manager/config_parser.rb'
#require_relative 'puppet-gem-manager/renderer.rb'

# These should be constants that are potentially overrideable by cli options
proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
config_path = proj_root + '/config/config.yml'
template_path = proj_root + '/templates/gemspec.erb'
pkg_path = proj_root + '/pkg'
gemspecs_path = pkg_path + '/gemspecs'
gems_path = pkg_path + '/gems'

matrix = PuppetGemManager::ConfigParser.build_gem_matrix(config_path)
matrix.keys.each do |gem|

  # This should be a config hash that gets passed into the renderer
  gem_name = gem
  gem_version = '0.0.1'
  build_date = Time.new.strftime("%Y-%m-%d")
  gem_summary = 'foo summary'
  gem_description = 'foo description'
  author = 'puppet'
  author_email = 'me@puppet.com'
  author_homepage = 'https://forge.puppet.com'
  gem_license = 'Apache-2.0'
  dependencies = matrix[gem]

  # Gemspec generation should be pulled out into a separate module
  # at some point.
  FileUtils.mkdir_p(gemspecs_path) unless File.exists?(gemspecs_path)
  FileUtils.mkdir_p(gems_path) unless File.exists?(gems_path)

  gemspec_file = gemspecs_path + "/#{gem_name}.gemspec"
  File.open(gemspec_file, 'w+') { |f|
    f.write(ERB.new(File.read(template_path), nil, '-').result(binding))
  }

  # a shim shell command here until I can figure out
  # a more elegant way of programmatically building a gem from gemspec
  value = `cd #{gems_path}; gem build #{gemspec_file}`
  puts value
end

