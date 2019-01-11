class User
  include Mongoid::Document
  field :role, type: String, default: "client"
  field :name, type: String
  field :imgUrl, type: String
  field :email, type: String
  field :token, type: String
  field :exponentPushToken, type: String
  # field :transactionId, type: Integer

  # has_many :transaction
end
