module VagrantPlugins
  module Recipe
    class Plugin < Vagrant.plugin(2)

      name 'Vagrant Recipe'
      description 'Plugin allows to execute a chef recipe.'

      config :run-recipe do
        require_relative 'config'
        Config
      end

      command :run-recipe do
        require_relative 'command'
        Command
      end

    end # Plugin
  end # Recipe
end # VagrantPlugins
