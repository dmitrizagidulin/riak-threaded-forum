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
  attribute :created_at, String, default: proc { DateTime.now.utc.iso8601 }
  
  validates_presence_of :name, :forum_key, :initial_post_key, :created_by
  
  # Used for caching the forum and initial post instances
  # Since these are not a document +attribute+, they will not be serialized to JSON
  attr_reader :forum
  attr_reader :initial_post
  
  def active?
    self.active == 'true'
  end
  
  def all_posts
    ForumPost.all_for_discussion(self.key)
  end

  def author
    @author ||= User.find(self.created_by) unless self.created_by.blank?
  end
  
  # Used for caching the author's User instance
  # Since this is not a document +attribute+, it will not be serialized to JSON
  def author=(user)
    @author = user
    self.created_by = user.key
  end
  
  def forum
    @forum ||= Forum.find(self.forum_key) unless self.forum_key.blank?
  end
  
  def forum=(forum)
    @forum = forum
    self.forum_key = forum.key
  end
  
  def has_replies?
    self.has_replies == 'true'
  end
  
  def initial_post=(post)
    @initial_post = post
    self.initial_post_key = post.key
  end
  
  def initialize_from_post(post)
    self.key = post.key  # Done for convenience / to keep the two in synch
    self.initial_post = post
    self.name = post.name
    self.forum = post.forum
    self.author = post.author
  end
  
  def username
    self.author.username if self.author
  end
  
  def self.all
    self.all_for_field(:active)
  end
  
  def self.all_for_forum(forum_key)
    query = { 
      :forum_key => forum_key,
      '$sort' => {'created_at' => 1} 
    }
    self.where(query)
  end
  
  # Creates a new discussion thread from a new post to a forum
  #
  # @param post_params [Hash] A new post to a forum that starts a thread
  # @param author [User] Author of post (usually current logged in user)
  # @param forum [Forum] Forum instance to which this discussion belongs
  # @param post_key [String,nil] Optional post key. If missing, auto-generated via UUID
  # @return [Discussion]
  def self.new_from_post(post_params, author, forum, post_key=nil)
    post = ForumPost.new(post_params)
    post.key = post_key || ForumPost.generate_uuid()  # Generate key, it will be needed below
    post.author = author
    post.forum = forum
    
    discussion = Discussion.new
    discussion.initialize_from_post(post)
    post.discussion_key = discussion.key
    discussion
  end
end