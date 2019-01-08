class OrderInfo
  include Mongoid::Document
  
  field :items, type: Array, default: []
  field :price, type: String
  field :ownerName, type: String
  field :ownerEmail, type: String
  field :status, type: String
  field :code, type: String
  field :date, type: String
  field :order
end
