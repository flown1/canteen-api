class Dish
  include Mongoid::Document
  field :_id, type: Integer
  field :namePL, type: String
  field :nameEN, type: String
  field :descPL, type: String
  field :descEN, type: String
  field :price, type: Float
  field :currency, type: String
  field :imgURL, type: String

  belongs_to :menu
end
