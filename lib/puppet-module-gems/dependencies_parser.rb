require 'yaml'
require 'deep_merge'

module PuppetModuleGems
  module DependenciesParser

    def self.build_gem_matrix(config_file_path)
      config = YAML.load_file(config_file_path)

      # Validate that YAML was able to read something and config is not nil or false.
      # Validate that the dependencies structure follows the requirements.
      if not config
        abort 'FAILED: [DependenciesParser] Failed to read Dependencies configuration file.'
      elsif not config.has_key? 'dependencies'
        abort 'FAILED: [DependenciesParser] Dependencies configuration is invalid. Missing top-level \'dependencies\' key.'
      end  

      deps = config['dependencies']
      if deps.nil? or deps.empty?
        abort 'FAILED: [DependenciesParser] Dependencies configuration contains no dependencies.'
      else
        parse_dependencies(deps)
      end
    end

    def self.parse_dependencies(config, name = '', results = {})
      shared = config.select { |k,v| k == 'shared' }.dup
      config = config.reject! { |k,v| k == 'shared' } || config
      
      # Merge in the shared dependencies
      if not shared.empty? and not shared['shared'].nil?
        config.keys.each do |key|
          if config[key].nil?
            config[key] = shared['shared']
          elsif shared['shared'].is_a? Hash
            config[key].deep_merge!(shared['shared'])
          elsif shared['shared'].is_a? Array
            config[key].concat(shared['shared'])
          end
        end
      end

      # Recurse through the matrix to find the core dependencies
      config.keys.each do |key|
        matrix_name = name.dup

        if config[key].nil? 
          matrix_name = "#{matrix_name}-#{key}"
          config[key] = shared['shared']
          results.merge!({"#{matrix_name}" => config[key]})
        elsif config[key].is_a? Array
          matrix_name = "#{matrix_name}-#{key}"
          results.merge!({"#{matrix_name}" => config[key]})
        elsif config[key].is_a? Hash
          matrix_name = matrix_name.empty? ? key : "#{matrix_name}-#{key}"
          results.merge!(parse_dependencies(config[key], matrix_name, results))
        else
          fail "Invalid config format: value for #{key} is a #{value.class.to_s}, must be nil, a Hash, or an Array"
        end
      end
      results
    end 

  end
end
