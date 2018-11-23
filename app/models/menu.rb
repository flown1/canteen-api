class Menu
  include Mongoid::Document
  field :id, type: Integer

  has_many :dish
end