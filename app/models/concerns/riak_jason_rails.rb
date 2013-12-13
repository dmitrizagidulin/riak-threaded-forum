require 'active_support/concern'

module RiakJasonRails
  extend ActiveSupport::Concern
  
  def save
  end
  
  module ClassMethods
    def all_for_field(field_name)
      collection = self.collection
      query = {field_name => {'$regex' => "/.*/"}}.to_json
      docs = collection.find(query)
      docs.documents
    end
    
    def collection
      client = RiakJson::Client.new
      collection = client.collection(self.collection_name)
    end
    
    def find(key)
      self.collection.find_by_key(key)
    end
  end
end