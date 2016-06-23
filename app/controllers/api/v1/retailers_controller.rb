class Api::V1::RetailersController < ApplicationController
  #before_action :login_auth
  before_action :set_retailer, only: %i(show update destroy)

  def index
    if params[:updated_after]
      @retailers = Retailer.status(params[:status]).where('updated_at >= ?', params[:updated_after])
    else
      @retailers = Retailer.status(params[:status])
    end
  end

  def show
  end

  def create
    @retailer = Retailer.new(retailer_params)
    @retailer.status = Retailer::ADDED
    if @retailer.save
      render :show, status: :ok
    else
      render json: @retailer.errors, status: :unprocessable_entity
    end
  end

  def update
    retailer = retailer_params
    retailer[:status] = Retailer::MODIFIED

    # TODO: 後でDRYにする
    unless retailer[:edited_at].nil?
      before_edited_at = Retailer.find(@retailer.id).edited_at
      if !before_edited_at.nil? and retailer[:edited_at] <= before_edited_at
        retailer[:edited_at] = before_edited_at
      end
    end

    if @retailer.update(retailer)
      render :show, status: :ok
    else
      render json: @retailer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @retailer.status = Retailer::DELETED
    if @retailer.save
      render :show, status: :ok
    else
      render json: @retailer.errors, status: :unprocessable_entity
    end
  end

  private
  def set_retailer
    @retailer = Retailer.find(params[:id])
  end

  def retailer_params
    params.permit(:name, :created_at, :updated_at, :edited_at)
  end
end
