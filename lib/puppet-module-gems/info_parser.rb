require 'yaml'

module PuppetModuleGems
  module InfoParser

    def self.get_info(file_path)
      config = YAML.load_file(file_path)

      # Validate that YAML was able to read something and config is not nil or false.
      # Validate that the information structure follows the requirements.
      if not config
        abort 'FAILED: [InfoParser] Failed to read Information configuration file.'
      elsif not config.has_key? 'info'
        abort 'FAILED: [InfoParser] Info configuration is invalid. Missing top-level \'info\' key.'
      end

      info = config['info']
      if info.nil? or info.empty?
        abort 'FAILED: [InfoParser] Info configuration file contains no information.'
      else
        [:prefix, :authors, :email, :homepage, :licenses, :summary, :version].each do |required_key|
          if not info.keys.include? required_key.to_s
            abort "FAILED: [InfoParser] Info Configuration is missing required key of #{required_key}."
          end
        end
      end

      info
    end

  end
end
