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

class ForumTest < ActiveSupport::TestCase
  describe "a Forum" do
    it "exists" do
      forum = Forum.new name: 'Book Club Discussions'
      forum.active.must_equal 'true', "Forums should be active by default"
      assert forum.active?
      
      Forum.collection_name.must_equal 'forums'
    end
  end
end