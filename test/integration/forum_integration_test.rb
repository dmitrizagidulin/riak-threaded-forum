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

describe "a Forum" do
  it "implements Forum.all" do
    forums = Forum.all
    forum = forums.first
    forum.must_be_kind_of Forum
    refute forum.new_record?, "A forum loaded from Forum.all() must not be marked as new_record"
    assert forum.persisted?, "A forum loaded from Forum.all() must be marked as persisted"
  end
  
  it "can list all ForumPosts belonging to it" do
    test_forum = 'forum-1'
    forum = Forum.find(test_forum)
    posts = forum.all_posts
    posts.wont_be_empty
    posts.first.must_be_kind_of ForumPost
  end
end