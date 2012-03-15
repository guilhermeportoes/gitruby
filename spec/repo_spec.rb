# encoding: utf-8
require "spec_helper"

describe Repo do
  context "without authentication" do
    it "should be findable by the github username/repository" do
      repo = Repo.find('janelas', 'guilhermeportoes')
      repo.name.should == 'janelas'
      repo.html_url.should == 'https://github.com/guilhermeportoes/janelas'
    end

    it "should convert the hash from api.github to public attributes" do
      repo = Repo.find('janelas', 'guilhermeportoes')
      get_janelas_repo.each do |key, value|
        repo.public_send(key).should == value
      end
    end

    def get_janelas_repo
      # temporary solution
      {
        "url"=>"https://api.github.com/repos/guilhermeportoes/janelas",
        "mirror_url"=>nil,
        "has_wiki?"=>true,
        "homepage"=>"",
        "svn_url"=>"https://github.com/guilhermeportoes/janelas",
        "open_issues"=>0,
        "updated_at"=>"2011-10-04T16:46:21Z",
        "watchers"=>1,
        "fork?"=>false,
        "pushed_at"=>"2011-07-08T23:05:46Z",
        "language"=>"Python",
        "private?"=>false,
        "git_url"=>"git://github.com/guilhermeportoes/janelas.git",
        "ssh_url"=>"git@github.com:guilhermeportoes/janelas.git",
        "clone_url"=>"https://github.com/guilhermeportoes/janelas.git",
        "size"=>96,
        "has_downloads?"=>true,
        "created_at"=>"2011-07-08T22:28:10Z",
        "owner"=>
          {"url"=>"https://api.github.com/users/guilhermeportoes",
          "login"=>"guilhermeportoes",
          "gravatar_id"=>"ba75dfc160b255796e769759ef482960",
          "id"=>903845,
          "avatar_url"=>
            "https://secure.gravatar.com/avatar/ba75dfc160b255796e769759ef482960?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png"},
        "name"=>"janelas",
        "has_issues?"=>true,
        "master_branch"=>nil,
        "id"=>2020355,
        "html_url"=>"https://github.com/guilhermeportoes/janelas",
        "description"=>"Uma merda que assolará a humanidade.",
        "forks"=>1
      }
    end

    it 'should not respond to github attributes when there are no results' do
      repo = Repo.new :foooooobar123
      repo.should_not respond_to :login
      repo.should_not respond_to :following
      repo.should_not respond_to :followers
    end
  end
end
