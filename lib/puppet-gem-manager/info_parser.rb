require 'yaml'

module PuppetGemManager
  module InfoParser

    def self.get_info(file_path)
      info = YAML.load_file(file_path)
      info['info']
    end

  end
end
