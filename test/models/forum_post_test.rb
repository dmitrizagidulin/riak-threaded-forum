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

class ForumPostTest < ActiveSupport::TestCase
  describe "a Forum Post" do
    it "exists" do
      post = ForumPost.new name: 'New Test Message'
    end
    
    it "can be posted as a reply to a discussion" do
      forum = sample_forum
      author = registered_user
      discussion = sample_discussion
      post_params = { 
        name: 'This is a reply to an existing discussion',
        body: 'Discussion reply body goes here'
      }
      post = ForumPost.reply_to_discussion(post_params, discussion, author)
      post.discussion_key.must_equal discussion.key
      post.forum_key.must_equal forum.key
      post.created_by.must_equal author.key
      post.thread_path.wont_be_empty
    end
  end
end