class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def index
    @users = User.all
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :password, :telephone)
  end
end
