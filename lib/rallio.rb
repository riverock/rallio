require 'httparty'
require 'virtus'
require 'autoloaded'

module Rallio
  Autoloaded.class {}

  def self.application_id=(value)
    @application_id = value
  end

  def self.application_id
    @application_id
  end

  def self.application_secret=(value)
    @application_secret = value
  end

  def self.application_secret
    @application_secret
  end
end
