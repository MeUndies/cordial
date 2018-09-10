require 'hashie'
require 'httparty'
require 'utils/compact'
require 'cordial/version'
require 'cordial/client'
require 'cordial/contacts'
require 'cordial/products'
require 'cordial/orders'
require 'cordial/automation_templates'

module Cordial
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end

  class Configuration
    attr_accessor :api_key
  end
end
