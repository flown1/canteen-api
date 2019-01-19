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
    @dish = Dish.find_or_initialize_by(:namePL => params[:dish][:namePL])
                .update_attributes!(:descPL => params[:dish][:descPL], 
                                    :imgUrl => params[:dish][:imgUrl],
                                    :price => params[:dish][:price],
                                    :tags => params[:dish][:tags])
    
    render json: {
      status: :SUCCESS,
      data: {
        dish: @dish
      }
    }, status: :OK    

  end

  def edit
    puts "EDITING..."
   
  end

  def update
    puts "UPDATING..."
    @dish.update(dish_params)
    head :no_content
  end

  def destroy
    puts "DESTROYING"
  end

  def delete
    puts "DELETING"
    @result = Dish.where(namePL: params[:namePL]).destroy

    if @result 
      render json: {
        status: :SUCCESS,
        data: {
        }
      }, status: :OK 
    else
      render json: {
        status: :ERROR,
        data: {
        }
      }, status: :ERROR
    end
  end
  
  private
  def dish_params
    params.permit(:namePL, :nameEN, :descPL, :descEN, 
                                  :price, :imgUrl, {:tags => []}, :currency, 
                                  :menu_id, :isPromoted)
  end

end
