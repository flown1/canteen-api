class DishOrder
  include Mongoid::Document
  field :id, type: Integer
  field :quantity, type: Integer

  belongs_to :transaction
  has_one :dish
end
