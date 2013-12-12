require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe "a User" do
    it "can be initialized" do
      user = User.new
    end
  end
end