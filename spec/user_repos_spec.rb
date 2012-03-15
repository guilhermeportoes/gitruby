require "spec_helper"

describe User do
  context "without authentication" do
    it "should be able to return all user's repositories" do
      user = User.find('guilhermeportoes')
      repo = user.repos['janelas']
      repo.name.should == 'janelas'
      repo.language.should == 'Python'
    end
  end
end
