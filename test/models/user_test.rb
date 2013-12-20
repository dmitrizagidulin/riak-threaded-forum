## ------------------------------------------------------------------- 
## 
## Copyright (c) "2013" Basho Technologies, Inc.
##
## This file is provided to you under the Apache License,
## Version 2.0 (the "License"); you may not use this file
## except in compliance with the License.  You may obtain
## a copy of the License at
##
##   http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing,
## software distributed under the License is distributed on an
## "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
## KIND, either express or implied.  See the License for the
## specific language governing permissions and limitations
## under the License.
##
## -------------------------------------------------------------------

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe "a User" do
    it "must have a username and password to be valid" do
      user = User.new
      refute user.valid?(:create), "New users should not be valid (require username and password fields)"
      user.password = '1234'
      user.password_confirmation = '1234'
      user.password_digest = BCrypt::Password.create('1234')
      user.username = 'test_user'
      assert user.valid?(:create)
    end
  end
end