class User
  @@collection_name = 'users'
  
  def self.all
    collection = self.collection
    query = {username: {'$regex' => "/.*/"}}.to_json
    docs = collection.find(query)
    docs.documents
  end
  
  def self.collection
    client = RiakJson::Client.new
    collection = client.collection(@@collection_name)
  end
  
  def self.find(user_key)
    self.collection.find_by_key(user_key)
  end
  
  def self.find_by_username(username)
    return nil if username.blank?
     
    query = {username: username}.to_json
    user = self.collection.find_one(query)
  end
end