require 'spec_helper'

# NOTE : This is really an integration test and it runs against SimpleDB
# with the credentials and prefix set up in config/intializers/aws.rb
describe User do
  describe 'validates_uniqueness_of' do
    before(:each) do
      User.create_domain
      User.all.each{|u| u.destroy }
      sleep(2) # allow a couple of seconds for SimpleDB to propagate
    end
    it "should only allow one user with the email address of 'jon@doh.com'" do
      # First create a new user and save it
      u = User.new(:email => 'jon@doh.com', :password => 'testpassword', :password_confirmation => 'testpassword')
      u.should be_valid
      u.save
      sleep(2) # we need to allow a couple of seconds for SimpleDB to propagate
      
      # Now create another user with the same email address
      # and make sure that it is not valid
      u2 = User.new(:email => 'jon@doh.com', :password => 'anotherpass', :password_confirmation => 'anotherpass')
      u2.should_not be_valid
      u2.errors[:email].should == ["has already been taken"]
    end
  end
end
