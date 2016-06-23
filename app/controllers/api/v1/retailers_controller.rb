class Api::V1::RetailersController < ApplicationController
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
    params.permit(:name, :created_at, :updated_at)
  end
end
