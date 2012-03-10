require 'httparty'
require 'mash'


class User < Mash

  BASE_URL = 'https://api.github.com/'

  def initialize(params=nil)
    if params.kind_of? String or params.kind_of? Symbol
      hash = HTTParty.get "#{BASE_URL}users/#{params}"
      super hash
    else
      super params
    end
  end
end
