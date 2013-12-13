require 'riak_json'
require 'riak_jason_rails'
require 'active_model'

class User
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::SecurePassword
  include RiakJasonRails
  
  attr_accessor :key
  attr_accessor :username, :password_digest
  attr_accessor :password
  
  has_secure_password validations: false
  
  def initialize(options={})
    @key = options.fetch(:key, nil)
    @username = options.fetch(:username, nil)
  end
  
  def save
    doc = RippleJson::Document.new(self.key)
    doc.body = {username: self.username, password_digest: self.password_digest}
    self.collection.insert(doc)
  end
  
  def self.collection_name
    'users'
  end
  
  def self.all
    self.all_for_field('username')
  end
  
  def self.find_by_username(username)
    return nil if username.blank?
     
    query = {username: username}.to_json
    user = self.collection.find_one(query)
  end
end