class OrdersController < ApplicationController
    def index
        puts "INDEX"
        @result = OrderInfo.all
        puts @result
        render json: {
            status: :SUCCESS,
            data: @result
        }, status: :OK
    end

    def new
        puts "NEW"
        puts order_info_params
        @orderInfo = OrderInfo.new(order_info_params)
    end

    def create
        puts "CREATE" 
        request.body.read

        @orderInfo = OrderInfo.new(order_info_params)
        @authCode = rand(1000..9999).to_s
        @orderInfo.code = @authCode
        
        @date = Time.now.to_s
        @orderInfo.date = @date
        
        puts @orderInfo.inspect
        if @orderInfo.save
            render json: {
                status: :SUCCESS,
                data: {
                    order: @orderInfo,
                    code: @authCode
                }
            }, status: :OK    
        else
            render json: {
                status: :ERROR,
                data: {}
            }, status: :ERROR    
        end
    end

    def edit
        puts "EDITING..."
    end

    def update
        puts "UPDATING..."
        @orderInfo.update(order_info_params)
        head :no_content
    end

    def destroy
    end

    private
    def order_info_params
        params.permit({:items => [
                                {:dish => {}}, :quantity
        ]}, :price, :ownerEmail, :ownerName, :status, :code, {:order => {}})
    end
end
