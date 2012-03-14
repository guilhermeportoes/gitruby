require 'httparty'

class User
  BASE_URL = 'https://api.github.com/'

  def initialize(params)
    if params.is_a? String or params.is_a? Symbol
      params = HTTParty.get "#{BASE_URL}users/#{params}"
    end
    params.each do |attr, value|
      if !!value == value
        self.class.send(:attr_writer, attr)
        self.class.send(:define_method, "#{attr}?") do
          instance_variable_get("@#{attr}")
        end
      else
        self.class.send(:attr_accessor, attr)
      end
      send("#{attr}=", value)
    end
  end

  def self.find(username)
    new(HTTParty.get "#{BASE_URL}users/#{username}")
  end
end

