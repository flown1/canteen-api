class User
  include Mongoid::Document
  field :id, type: Integer
  field :role, type: String
  field :name, type: String
  field :email, type: String
  field :token, type: String
  field :transactionId, type: Integer

  has_many :transaction
end
