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
  include ActiveModel::Validations
  
  attribute :name, String  # Post title
  attribute :body, String, :default => ""  # Post body
  attribute :forum_key, String  # Forum to 
  attribute :created_by, String  # Key of user who created this post

  # Threading / reply-to attributes
  attribute :reply_to, String, :default => ""  # Optional key of parent forum post
  attribute :thread_path, String, :default => ""  # Used for reconstructing discussion tree structure
  attribute :indent_level, Integer, :default => 0
  
  validates_presence_of :name, :forum_key, :created_by
  
  def username
    user = User.find(self.created_by)
    user.username if user
  end
  
  def forum
    Forum.find(self.forum_key)
  end
  
  def self.all
    self.all_for_field('name')
  end
  
  def self.all_for_forum(forum_key)
    query = { :forum_key => forum_key }.to_json
    self.where(query)
  end
end