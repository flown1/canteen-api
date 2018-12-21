class UsersController < ApplicationController
  def index
    
    render json: {
      data: "User created OK"
    }, status: :OK

  end

  def new
    puts "NEW"
    @user = User.new(user_params)
    # if @user = User.where(email: params[:user][:email]).first_or_create
    #   puts "User already exists! Just sending back token"   
    #   render json: {
    #         status: :SUCCESS,
    #         data: @user
    #   }, status: :OK  
    # else
    #   @user = User.new
    #   render json: {
    #         status: :SUCCESS,
    #         data: @user
    #   }, status: :OK  
    # end
  end

  def create
    puts "CREATE" 
    user = User.where(email: params[:user][:email]).first
    if user
      puts "User already exists"
      render json: {
          status: :SUCCESS,
          data: user
        }, status: :OK   
    else
      @user = User.new(user_params)

      if @user.save
        puts "NEW USER CREATED"
        render json: {
          status: :SUCCESS,
          data: @user
        }, status: :OK    
      else
        puts "USER not created"
        render json: {
            status: :internal_server_error,
            data: @user
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
  def user_params
    params.require(:user).permit(:name, :email, :imgUrl, :serverAuthCode)
  end

end
