class Dish
  include Mongoid::Document
  field :namePL, type: String
  field :nameEN, type: String
  field :descPL, type: String
  field :descEN, type: String
  field :price, type: Float
  field :currency, type: String
  field :imgUrl, type: String
  field :tags, type: Array, default: []
  field :isPromoted, type: Boolean

  # belongs_to :menu
end
