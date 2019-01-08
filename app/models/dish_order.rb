class DishOrder
  include Mongoid::Document
  field :dish, type: Dish
  field :quantity, type: Integer

  # belongs_to :transaction
  # has_one :dish
end
