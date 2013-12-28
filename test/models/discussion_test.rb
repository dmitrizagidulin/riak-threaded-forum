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

class DiscussionTest < ActiveSupport::TestCase
  describe "a Discussion Thread" do
    it "exists" do
      discussion = Discussion.new(name: 'Test discussion')
      assert discussion.active?, "Discussion should be active by default"
      refute discussion.has_replies?, "A newly created thread should have no replies"
    end
    
    it "checks for required fields" do
      discussion = Discussion.new
      refute discussion.valid?, "A discussion needs a name, forum key, author key and post key to be valid"
      discussion.name = 'Test discussion'
      discussion.forum_key = 'forum-123'
      discussion.initial_post_key = 'post-123'
      discussion.created_by = 'user-123'
      assert discussion.valid?
    end
  end
end