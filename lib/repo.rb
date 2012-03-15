# encoding: utf-8

require 'httparty'

class Repo
  BASE_URL = 'https://api.github.com/'

  def initialize(params, username=nil)
    if username and params.is_a? String or params.is_a? Symbol
      params = HTTParty.get "#{BASE_URL}repos/#{username}/#{}"
    end
    params.each do |attr, value|
      if !!value == value
        self.singleton_class.send(:attr_writer, attr)
        self.singleton_class.send(:define_method, "#{attr}?") do
          instance_variable_get("@#{attr}")
        end
      else
        self.singleton_class.send(:attr_accessor, attr)
      end
      send("#{attr}=", value)
    end
  end

  def self.find(username, repository)
    new(HTTParty.get "#{BASE_URL}repos/#{username}/#{repository}")
  end
end
