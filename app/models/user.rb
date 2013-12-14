
class User
  include RiakJson::ActiveDocument
  include ActiveModel::Validations
  include ActiveModel::SecurePassword
  
  attribute :username, String
  attribute :password, String
  attribute :password_digest, String
  
  has_secure_password validations: false
  
  def self.find_by_username(username)
    return nil if username.blank?
     
    query = {username: username}.to_json
    user = self.collection.find_one(query)
  end
end