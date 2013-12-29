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

class ForumPost
  include RiakJson::ActiveDocument
  
  # Document Attributes
  attribute :name, String  # Post title
  attribute :body, String, :default => ""  # Post body
  attribute :forum_key, String  # Forum to which this was posted
  attribute :discussion_key, String  # Key of discussion thread to which this post belongs
  attribute :created_by, String  # Key of user who created this post

  attribute :reply_to, String, :default => ""  # Optional key of parent post
  attribute :thread_path, String, :default => ""  # Used for reconstructing discussion tree structure
  attribute :indent_level, Integer, :default => 0
  
  attribute :created_at, String, default: proc { DateTime.now.utc.iso8601 }  # Timestamp
  
  validates_presence_of :name, :forum_key, :created_by, :discussion_key
  
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
  
  # Used for caching the post author's User instance
  # Since this is not a document +attribute+, it will not be serialized to JSON
  def forum=(forum)
    @forum = forum
    self.forum_key = forum.key
  end
  
  def username
    self.author.username if self.author
  end
  
  # Is this post a reply to another post?
  # @return [Boolean] Returns +true+ if this post is a reply, +false+ if this is a top-level post
  def is_reply?
    self.reply_to.present? && self.indent_level > 0
  end
  
  # Returns true if this post was the original post for a discussion
  def root_post?
    (self.discussion_key == self.key) && (self.indent_level == 0)
  end
  
  def self.all
    self.all_for_field('name')
  end
  
  def self.all_for_discussion(discussion_key, threaded=false)
    query = { :discussion_key => discussion_key }
    if threaded
      query['$sort'] = {'thread_path' => 1}
    else
      query['$sort'] = {'created_at' => 1}
    end
    self.where(query)
  end
  
  def self.all_for_forum(forum_key)
    query = { :forum_key => forum_key }
    self.where(query)
  end
  
  # Generates a UUID for use as the id/key
  def self.generate_uuid
    SecureRandom.uuid.gsub(/-/, '')
  end
  
  def self.reply_to(reply_to_post, user, forum_post_params={})
    # TODO: Check to see if reply_to_post is a valid post, raise error otherwise
    post = ForumPost.new(forum_post_params)
    post.created_by = user.key
    post.discussion_key = reply_to_post.discussion_key
    
    post.forum_key = reply_to_post.forum_key
    post.reply_to = reply_to_post.key
    post.indent_level = reply_to_post.indent_level + 1
    
    # Set the default reply title
    unless forum_post_params.include? :name
      if reply_to_post.name.start_with? "Re:"
        post.name = reply_to_post.name
      else
        post.name = "Re: #{reply_to_post.name}"
      end
    end
    
    if reply_to_post.is_reply?
      post.thread_path = "#{reply_to_post.thread_path}/#{reply_to_post.key}/"
    else
      # Parent post is not a reply, but is a top level post
      post.thread_path = "#{reply_to_post.key}/"
    end
    post
  end
  
  def self.reply_to_discussion(forum_post_params, discussion, author)
    post = ForumPost.new(forum_post_params)
    post.name ||= "Re: #{discussion.name}"
    post.author = author
    post.forum = discussion.forum
    post.discussion_key = discussion.key
    post.reply_to = discussion.initial_post_key
    # Parent post is not a reply, but is a top level post
    post.thread_path = "#{post.reply_to}/"
    post
  end
end