require 'httparty'
require 'virtus'
require 'rallio/version'
require 'rallio/base'
require 'rallio/user'
require 'rallio/sign_on_token'

module Rallio
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
