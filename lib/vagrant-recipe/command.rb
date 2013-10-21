module VagrantPlugins
  module Recipe
    class Command < Vagrant.plugin(2, :command)

      def execute
        cmd, cmd_args = parse_args
        cmd && cmd_args or return nil

        # Execute the actual SSH
        with_target_vms(nil, single_target: true) do |vm|
          vm.config.recipe.finalize! # TODO: do we have to call it explicitly?

          plain   = "sudo chef-solo -c #{vm.config.recipe.chef} -j #{vm.config.recipe.json} --override-runlist \"recipe[#{cmd}]\""
          command = ""

          command << add_env(vm.config.recipe.env)
          #command << add_bundler(vm.config.recipe.bundler, plain)
          command << plain

          @logger.info("Executing recipe on remote machine: #{command}")
          env = vm.action(:ssh_run, ssh_run_command: command)

          status = env[:ssh_run_exit_status] || 0
          return status
        end
      end

      private

      def parse_args
        opts = OptionParser.new do |o|
          o.banner = 'Usage: vagrant run-recipe <recipe-name>'
          o.separator ''

          o.on('-h', '--help', 'Print this help') do
            safe_puts(opts.help)
          end
        end

        argv = split_main_and_subcommand(@argv.dup)
        exec_args, cmd, cmd_args = argv[0], argv[1], argv[2]

        # show help
        if !cmd || exec_args.any? { |a| a == '-h' || a == '--help' }
          safe_puts(opts.help)
          return nil
        end

        return cmd, cmd_args
      end

      def add_env(env)
        ''.tap do |command|
          if env.any?
            env.each do |key, value|
              command << "export #{key}=#{value} && "
            end
          end
        end
      end

      def add_bundler(bundler, plain_command)
        ''.tap do |command|
          if bundler && plain_command !~ /^bundle /
            command << 'bundle exec '
          end
        end
      end

    end # Command
  end # Recipe
end # VagrantPlugins
