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
    @dish = Dish.new(dish_params)
  end

  def create
    puts "CREATE" 
    dish = Dish.where(namePL: params[:dish][:namePL]).first
    if dish
      puts "Dish already exists"
      render json: {
          status: :SUCCESS,
          data: dish
        }, status: :OK   
    else
      @dish = Dish.new(dish_params)

      if @dish.save!
        puts "NEW DISH CREATED"
        render json: {
          status: :SUCCESS,
          data: @dish
        }, status: :OK    
      else
        # @dish.errors
        puts "DISH not created"
        dish.errors
        render json: {
            status: :internal_server_error,
            data: @dish
        }, status: :internal_server_error 
      end
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
    params.require(:dish).permit(:namePL, :nameEN, :descPL, :descEN, 
                                  :price, :imgUrl, {:tags => []}, :currency, 
                                  :menu_id, :isPromoted)
  end

end
