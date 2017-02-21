require 'erb'
require 'fileutils'

module PuppetGemManager
  module GemspecRenderer

    def self.generate_gemspec(gemspec, template_path, output_path)
      # Gemspec generation should be pulled out into a separate module
      # at some point.
      FileUtils.mkdir_p(output_path) unless File.exists?(output_path)
      FileUtils.mkdir_p(output_path) unless File.exists?(output_path)

      gemspec_file = output_path + "/#{gemspec['name']}.gemspec"
      File.open(gemspec_file, 'w+') { |f|
        f.write(ERB.new(File.read(template_path), nil, '-').result(binding))
      }
    end

  end
end
