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

class Forum
  include RiakJson::ActiveDocument
  
  attribute :name, String
  attribute :active, String, default: 'true'
  
  validates_presence_of :name
  
  def active?
    self.active == 'true'
  end
  
  def all_discussions
    Discussion.all_for_forum(self.key)
  end
  
  def all_posts
    ForumPost.all_for_forum(self.key)
  end
  
  def self.all
    self.all_for_field(:active)
#    begin
#      self.all_for_field(:active)
#    rescue RestClient::InternalServerError => e
#      puts e.inspect
#    end
  end
end