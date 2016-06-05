class Api::V1::RetailersController < ApplicationController
  before_action :set_retailer, only: %i(show update destroy)

  def index
    @retailers = case (params[:status])
                   when 'modified'
                     Retailer.modified
                   when 'added'
                     Retailer.added
                   when 'deleted'
                     Retailer.deleted
                   else
                     Retailer.default
                 end
  end

  def show
  end

  def create
    @retailer = Retailer.new(retailer_params)
    if @retailer.save
      render :show, status: :ok
    else
      render json: @retailer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @retailer.update(retailer_params)
      render :show, status: :ok
    else
      render json: @retailer.errors, status: :unprocessable_entity
    end
  end

  def delete
    @retailer.destroy
    format.json { head :no_content }
  end

  private
  def set_retailer
    @retailer = Retailer.find(params[:id])
  end

  def retailer_params
    params.permit(:name, :status, :created_at, :updated_at)
  end
end