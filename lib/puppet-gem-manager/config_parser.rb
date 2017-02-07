require 'yaml'

module PuppetGemManager
  module ConfigParser

    def self.build_gem_matrix(config_file_path)
      config = YAML.load_file(config_file_path)
      parse_config(config)
    end

    def self.parse_config(config, name = '', results = {})
      shared = config.select { |k,v| k == 'shared' }
      config = config.reject! { |k,v| k == 'shared' } || config

      config.keys.each do |key|
        matrix_name = name.dup

        if config[key].nil? 
          matrix_name = "#{matrix_name}-#{key}"
          config[key] = shared['shared']
          results.merge!({"#{matrix_name}" => config[key]})
        elsif config[key].is_a? Array
          matrix_name = "#{matrix_name}-#{key}"
          config[key].concat(shared['shared']) unless shared['shared'].nil? or not shared['shared'].is_a? Array
          results.merge!({"#{matrix_name}" => config[key]})
        elsif config[key].is_a? Hash
          matrix_name = matrix_name.empty? ? key : "#{matrix_name}-#{key}"
          config[key].merge!(shared['shared']) unless shared['shared'].nil?
          results.merge!(parse_config(config[key], matrix_name, results))
        else
          fail "Invalid config format: value for #{key} is a #{value.class.to_s}, must be nil, a Hash, or an Array"
        end
      end
      results
    end 

  end
end
