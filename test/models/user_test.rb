require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe "a User" do
    it "can be initialized" do
      user = User.new
    end
    
    it "has a collection name" do
      User.collection_name.must_equal 'users'
    end
    
    it "implements a find (by key) method" do
      user = User.find('abe')
      user.key = 'abe'
    end
    
    it "implements an all() method" do
      users = User.all
      users.wont_be_empty
    end
    
    it "implements a save() instance method" do
      user = User.new(username: 'george')
      
    end
  end
end