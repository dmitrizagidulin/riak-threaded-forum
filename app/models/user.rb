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

class User
  include RiakJson::ActiveDocument
  include ActiveModel::Validations
  include ActiveModel::SecurePassword
  
  attribute :username, String
  attribute :password_digest, String

  validates_presence_of :username

  # ActiveModel#has_secure_password automatically adds presence validations on :create 
  # for :password, :password_confirmation and :password_digest
  has_secure_password

  def self.all
    self.all_for_field(:username)
  end
  
  def self.find_by_username(username)
    return nil if username.blank?
    
    query = {username: username}.to_json
    self.find_one(query)
  end
end