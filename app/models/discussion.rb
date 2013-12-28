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

class Discussion
  include RiakJson::ActiveDocument
  
  attribute :name, String
  attribute :active, String, default: 'true'
  attribute :forum_key, String
  attribute :initial_post_key, String  # Key of the first post to this discussion thread
  attribute :created_by, String  # Key of user who created this discussion
  attribute :has_replies, String, default: 'false'
  
  validates_presence_of :name, :forum_key, :initial_post_key, :created_by
  
  def active?
    self.active == 'true'
  end
  
  def all_posts
    ForumPost.all_for_discussion(self.key)
  end

  def forum=(forum)
    self.forum_key = forum.key
  end
  
  def has_replies?
    self.has_replies == 'true'
  end
  
  def self.all
    self.all_for_field(:active)
  end
  
  # Creates a new discussion thread from a new post to a forum
  #
  # @param post [ForumPost] A new post to a forum that starts a thread
  # @param author [User] Author of post (usually current logged in user)
  # @param forum [Forum] Forum instance to which this discussion belongs
  # @return [Discussion]
  def self.new_from_post(post, author, forum)
    discussion = Discussion.new
    discussion.name = post.name
    discussion.forum = forum
    discussion.created_by = author.key
    discussion.initial_post_key = post.key
    discussion
  end
end