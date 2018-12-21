class DishesController < ApplicationController
  def index
    @result = Dish.all
    puts @result
    render json: {
        status: :SUCCESS,
        data: @result
    }, status: :OK
  end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      puts "created"
      redirect_to "/", notice: "Dish has been created!" and return
    else
      puts "not creted"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def dish_params
    params.require(:dish).permit(:namePL, :nameEN, :descPL, :descEN, :price, :currency, :imgUrl, :menu_id, :tags, :isPromoted)
  end

end
