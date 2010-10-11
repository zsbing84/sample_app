require 'spec_helper'

describe User do
	
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com" }
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
  end
  
end


