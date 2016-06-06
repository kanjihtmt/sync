class Api::V1::SessionsController < ApplicationController
  skip_before_action :login_auth

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      logger.debug(session[:user_id])
      redirect_to api_v1_user_path user
    else
      render json: { status: 401, message: 'Authenticate Error' }, status: 401
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {message: 'logouted'}, status: 200
  end
end
