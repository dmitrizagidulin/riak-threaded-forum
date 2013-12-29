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
  
  it "has a sample_discussion test_helper method" do
    discussion = sample_discussion
    assert discussion.valid?
    assert discussion.initial_post.valid?
  end
  
  it "belongs to a forum" do
    discussion = Discussion.new name: 'Test discussion'
    forum = sample_forum()
    discussion.forum = forum
    discussion.forum_key.must_equal forum.key
  end
  
  it "is created by posting to a forum" do
    forum = sample_forum
    author = registered_user
    post_params = { 
      name: 'Test post that starts a new discussion',
      body: 'Post body goes here'
    }
    # Create a new discussion object (and its initial post object)
    discussion = Discussion.new_from_post(post_params, author, forum)
    post = discussion.initial_post
    assert post.root_post?
    # Both should be valid
    assert post.valid?
    assert discussion.valid?
    # Both should have the same key, and have references to each other
    discussion.key.must_equal post.key, "A discussion and its initial post should have the same key, for convenience"
    discussion.initial_post_key.must_equal post.key
    post.discussion_key.must_equal discussion.key
    # Check that the forum key is initialized in both objects
    discussion.forum_key.must_equal forum.key
    post.forum_key.must_equal forum.key
    # Names and author key should be the same
    discussion.name.must_equal post.name
    discussion.created_by.must_equal author.key
  end
end