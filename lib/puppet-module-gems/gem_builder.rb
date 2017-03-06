module PuppetModuleGems
  module GemBuilder

    def self.build_all_gems(pkg_path)
      gemspecs = Dir["#{pkg_path}/*.gemspec"]

      gemspecs.each do |gemspec|
        build_gem(gemspec)
      end
    end

    def self.build_gem(gemspec_file)
      dir = File.dirname(gemspec_file)

      # Using a shell command to build the gem for now until I can figure out
      # a better way to build the gem programatically
      value = `cd #{dir}; gem build #{gemspec_file}`
      puts value
    end

  end
end
