require 'httparty'
require './lib/repo'

class User
  BASE_URL = 'https://api.github.com/'

  def initialize(params)
    if params.is_a? String or params.is_a? Symbol
      params = HTTParty.get "#{BASE_URL}users/#{params}"
      @login = params
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

  def self.find(username)
    new(HTTParty.get "#{BASE_URL}users/#{username}")
  end

  def repos
    if not @repos
      params = HTTParty.get "#{BASE_URL}users/#{@login}/repos"
      @repos = []
      params.each do |repo|
        @repos << Repo.new(repo)
      end
    end
    return @repos
  end
end
