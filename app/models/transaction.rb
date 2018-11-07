class Transaction
  include Mongoid::Document
  field :id, type: Interger
  field :created, type: String

  belongs_to :user
  has_many :dishOrder
end
