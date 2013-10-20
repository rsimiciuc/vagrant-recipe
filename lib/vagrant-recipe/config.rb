module VagrantPlugins
  module Recipe
    class Config < Vagrant.plugin(2, :config)

      attr_reader :env
      attr_accessor :bundler
      attr_accessor :chef
      attr_accessor :json

      def initialize
        @env     = {}
        @bundler = UNSET_VALUE
        @chef  = UNSET_VALUE
        @json = UNSET_VALUE
      end

      def validate(_)
        return { 'exec' => ['bundler should be boolean'] } unless [true, false].include?(@bundler)
        return { 'exec' => ['chef should be a string'] } unless @chef.is_a?(String)
        return { 'exec' => ['json should be a string'] } unless @json.is_a?(String)

        {}
      end

      def finalize!
        @chef  = '/tmp/vagrant-chef-1/solo.rb' if @chef  == UNSET_VALUE
        @json  = '/tmp/vagrant-chef-1/dna.json' if @json  == UNSET_VALUE
        @bundler = false      if @bundler == UNSET_VALUE
      end

    end # Config
  end # Recipe
end # VagrantPlugins
