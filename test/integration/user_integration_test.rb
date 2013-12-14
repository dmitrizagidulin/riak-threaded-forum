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

describe "a User" do
  it "implements User.find_by_username" do
    # Ensure that a user object exists in the collection
    user = User.new username: 'earl', password: '1234', password_confirmation: '1234'
    user.key = 'earl-123'
    user.save
    
    
    
    found_user = User.find_by_username('earl')
    found_user.key.must_equal 'earl-123'
  end
end