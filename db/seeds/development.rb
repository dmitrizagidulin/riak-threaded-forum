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

# Seed Users collection
puts "Seeding Users for env: #{Rails.env}"
user = User.new(username: 'registered_user', password: '12345', password_digest: BCrypt::Password.create('12345'))
user.key = 'user-1'
user.save

user = User.new username: 'earl', password: '1234', password_confirmation: '1234'
user.key = 'earl-123'
user.save

# Seed Forums collection
puts "Seeding Forums..."
forum = Forum.new(name: 'Distributed Systems Discussions')
forum.key = 'forum-1'
forum.save

# Seed ForumPosts collection
puts "Seeding Forum Posts..."
forum_post = ForumPost.new name: 'Test Post'
forum_post.key = 'post-123'
forum_post.forum_key = forum.key
forum_post.created_by = user.key
forum_post.body = 'Test post contents are updated via unit tests, do not be alarmed.'
forum_post.save