require "spec_helper"

describe User do
  context "without authentication" do
    it "should be findable by the github username" do
      user = User.find("octocat")
      user.login.should == 'octocat'
      user.html_url.should == 'https://github.com/octocat'
    end

    it "should convert the hash from api.github to public attributes" do
      user = User.find('octocat')
      get_octocat_user.each do |key, value|
        user.public_send(key).should == value
      end
    end

    def get_octocat_user
      # temporary solution
      {
        "type" => "User",
        "following" => 0,
        "hireable?" => false,
        "public_repos" => 3,
        "followers" => 132,
        "html_url" => "https://github.com/octocat",
        "bio" => nil,
        "avatar_url" => "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
        "login" => "octocat",
        "public_gists" => 4,
        "created_at" => "2011-01-25T18:44:36Z",
        "location" => "San Francisco",
        "blog" => "http://www.github.com/blog",
        "name" => "The Octocat",
        "company" => "GitHub",
        "email" => "octocat@github.com",
        "url" => "https://api.github.com/users/octocat",
        "id" => 583231,
        "gravatar_id" =>"7ad39074b0584bc555d0417ae3e7d974"
      }
    end

    it 'should not respond to github attributes when there are no results' do
      user = User.new('')
      user.should_not respond_to :login
      user.should_not respond_to :following
      user.should_not respond_to :followers
    end
  end
end

