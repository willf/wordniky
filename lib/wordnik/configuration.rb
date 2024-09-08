# frozen_string_literal: true

require 'yaml'

module Wordnik
  class Configuration
    attr_accessor :api_key, :api_url, :api_version, :connection

    def initialize
      defaults = {
        api_url: 'https://api.wordnik.com',
        api_version: 'v4'
      }
      loaded = look_for_config_file
      @api_key = loaded['api_key'] || ENV['WORDNIK_API_KEY']
      @api_url = loaded['api_url'] || defaults[:api_url]
      @api_version = loaded['api_version'] || defaults[:api_version]
      return unless @api_key.nil?

      raise 'No API key found. Please set it in the environment variable WORDNIK_API_KEY or in a .wordnik.yml file'
    end

    def look_for_config_file
      if File.exist?('.wordnik.yml')
        YAML.load_file('.wordnik.yml')
      elsif File.exist?(File.join(Dir.home, '.wordnik.yml'))
        YAML.load_file(File.join(Dir.home, '.wordnik.yml'))
      else
        {}
      end
    end

    def to_s
      "<Configuration api_key: *****, api_url: #{@api_url}, api_version: #{@api_version}>"
    end

    def inspect
      to_s
    end
  end
end
