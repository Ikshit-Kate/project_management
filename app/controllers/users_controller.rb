class UsersController < ApplicationController
	before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  def index
    @users = User.all 
    render json: @users.map{ |user| 
      if user.avatar.attached? 
        user.as_json(only: :name).merge(avatar_path: url_for(user.avatar))
      else 
         user.as_json(only: :name)
      end}
  end

  def show
    if @user.avatar.attached? 
       render json: @user.as_json(only: %i[name]).merge(avatar_path: url_for(@user.avatar))
    else 
      render json: @user.as_json(only: :name)
    end 
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:avatar, :name, :username, :email, :password, :password_confirmation)
  end

end
