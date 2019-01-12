class UsersController < ApplicationController
  protect_from_forgery with: :null_session, if: ->{request.format.json?}
  skip_before_action :verify_authenticity_token
  def index
    
    render json: {
      data: "User created OK"
    }, status: :OK

  end

  def new
    puts "NEW"
    @user = User.new(user_params)
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

  def updateExponentPushToken
    @user = User.find_by(email: params[:email]);
    puts @user
    puts params[:exponentPushToken]

    if @user 
      puts "FOUND USER TO UPDATE TOKEN"
      @user.update(exponentPushToken: params[:exponentPushToken])
      puts "USER AFTER UPDATE:"
      puts @user.inspect
      
      render json: {
        status: :OK,
        data: {}
      }, status: :OK
    else
      puts "HAVEN'T FOUND USER TO UPDATE TOKEN"
      render json: {
        status: :ERROR,
        data: {}
      }, status: :ERROR
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :imgUrl, :serverAuthCode, :exponentPushToken)
  end

end
