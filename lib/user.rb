require 'httparty'

class User
  BASE_URL = 'https://api.github.com/'

  # TODO: generate attr_accessor dinamically
  attr_accessor :type, :following, :followers, :html_url, :bio, :avatar_url,
                :login, :public_gists, :created_at, :location, :blog,
                :name, :company, :email, :url, :gravatar_id, :public_repos,
                :hireable, :id

  def initialize(params)
    if params.is_a? String or params.is_a? Symbol
      params = HTTParty.get "#{BASE_URL}users/#{params}"
    end
    params.each { |attr, value| __send__("#{attr}=", value)}
  end

  def self.find(username)
    new(HTTParty.get "#{BASE_URL}users/#{username}")
  end
end
