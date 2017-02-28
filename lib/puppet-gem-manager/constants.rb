module PuppetGemManager
  module Constants

    proj_root = File.expand_path(File.join(File.dirname(__FILE__), '../..'))
    CONFIG_PATH       = "#{proj_root}/config"
    INFO_FILE         = "#{CONFIG_PATH}/info.yml"
    DEPENDENCIES_FILE = "#{CONFIG_PATH}/dependencies.yml"
    TEMPLATE_FILE     = "#{proj_root}/templates/gemspec.erb"
    PKG_PATH          = "#{proj_root}/pkg"

  end
end
