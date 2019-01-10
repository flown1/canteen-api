class OrdersController < ApplicationController
    def index
        puts "INDEX"
        @result = OrderInfo.all
        render json: {
            status: :SUCCESS,
            data: @result
        }, status: :OK
    end
    
    def new
        puts "NEW"
        @orderInfo = OrderInfo.new(order_info_params)
    end

    def create
        puts "CREATE" 

        @orderInfo = OrderInfo.new(order_info_params)
        @authCode = rand(1000..9999).to_s
        @orderInfo.code = @authCode
        
        @date = Time.now.to_s
        @orderInfo.date = @date
        
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

    def getIncomplete
        puts "GETTING INCOMPLETE ORDERS..."
        @result = OrderInfo.where(:status.ne => "COMPLETE")

        if @result
            render json: {
                status: :SUCCESS,
                data: {
                    orders: @result
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

    def getUserOrders
        puts "GETTING USER's ORDERS..."
        @email = params[:ownerEmail]
        @result = OrderInfo.where(:ownerEmail => @email)
                            .where(:status.ne => "COMPLETE")

        if @result
            render json: {
                status: :SUCCESS,
                data: {
                    orders: @result
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

    def getUserOrdersArchive
        puts "GETTING USER's ORDERS ARCHIVE..."
        @email = params[:ownerEmail]
        @result = OrderInfo.where(:ownerEmail => @email)
                            .where(:status => "COMPLETE")

        if @result
            render json: {
                status: :SUCCESS,
                data: {
                    orders: @result
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

    def getOrdersArchive
        puts "GETTING ORDERS ARCHIVE..."
        @email = params[:ownerEmail]
        @result = OrderInfo.where(:status => "COMPLETE")

        if @result
            render json: {
                status: :SUCCESS,
                data: {
                    orders: @result
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

    def setReady
        puts "SETTING ORDER as READY..."

        @id = params[:orderId]
        @result = OrderInfo.find(@id)

        if @result 
            puts "FOUND RECORD"
            @result.update_attributes(:status => "READY")
            render json: {
                status: :OK,
                data: {}
            }, status: :OK
        else
            puts "HAVE NOT FOUND RECORD"
            render json: {
                status: :ERROR,
                data: {}
            }, status: :ERROR
        end
    end

    def setComplete
        puts "SETTING ORDER as COMPLETE..."

        @id = params[:orderId]
        @result = OrderInfo.find(@id)

        if @result 
            puts "FOUND RECORD"
            @result.update_attributes(:status => "COMPLETE")
            render json: {
                status: :OK,
                data: {}
            }, status: :OK
        else
            puts "HAVE NOT FOUND RECORD"
            render json: {
                status: :ERROR,
                data: {}
            }, status: :ERROR
        end
    end

    private
    def order_info_params
        params.permit({:items => [{:dish => {}}, :quantity]}, 
                    :price, :ownerEmail, :ownerName, :status, :code, {:order => {}}) #:orderId jeszcze?
    end
end
