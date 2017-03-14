require 'httparty'
require 'virtus'
require 'autoloaded'

module Rallio
  Autoloaded.class {}

  # Sets the oauth application id received from Rallio.
  #
  # @param value [String] the oauth application id token
  # @return [String] value
  def self.application_id=(value)
    @application_id = value
  end

  # Retreives application id token.
  #
  # @return [String, nil] the application id or nil
  def self.application_id
    @application_id
  end

  # Sets the oauth application secret received from Rallio.
  #
  # @param value [String] the oauth application secret token
  # @return [String] value
  def self.application_secret=(value)
    @application_secret = value
  end

  # Retreives application secret token.
  #
  # @return [String, nil] the application secret or nil
  def self.application_secret
    @application_secret
  end
end
