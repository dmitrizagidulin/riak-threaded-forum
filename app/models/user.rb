class User
  def self.all
    client = RiakJson::Client.new
    collection = client.collection('users')
#    user = MyUser.new( username: 'george', )
#    user.key = 'george'
#    collection.store
    
    query = {username: {'$regex' => "/.*/"}}.to_json
    docs = collection.find(query)
    docs.documents
  end
end