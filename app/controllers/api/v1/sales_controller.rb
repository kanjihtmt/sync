class Api::V1::SalesController < ApplicationController
  before_action :set_sale, only: %i(show update destroy)

  def index
    @sales = Sale.status(params[:status])
  end

  def show
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.status = Sale::ADDED
    if @sale.save
      render :show, status: :ok
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  def update
    sale = sale_params
    sale[:status] = Sale::MODIFIED
    if @sale.update(sale)
      render :show, status: :ok
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @sale.status = Sale::DELETED
    if @sale.save
      render :show, status: :ok
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  private
  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.permit(:amount, :status, :retailer_id, :created_at, :updated_at)
  end
end
