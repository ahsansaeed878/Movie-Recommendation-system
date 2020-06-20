class UsersController < ApplicationController

  #/user/new
  def new
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.messages
    end
  end

  #/user?email
  def update
    @user = User.find_by(email: params[:email]) if params[:email].present?
    if @user.present?
      @user.update(user_params)
      render json: "User updated successfully!"
    else
      render json: "User not found!"
    end
  end

  #/user?email
  def destroy
    @user = User.find_by(email: params[:email]) if params[:email].present?
    if @user.present?
      @user.destroy
      render json: "User deleted successfully!"
    else
      render json: "User not found!"
    end
  end

  private
    def user_params
      params.permit(:name, :email)
    end
end
