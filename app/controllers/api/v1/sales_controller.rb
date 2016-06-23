class Api::V1::SalesController < ApplicationController
  before_action :set_sale, only: %i(show update destroy)

  def index
    if params[:updated_after]
      @sales = Sale.status(params[:status]).where('updated_at >= ?', params[:updated_after])
    else
      @sales = Sale.status(params[:status])
    end
  end

  def show
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.status = Sale::ADDED
    if @sale.save
      if @sale.retailer.status == Retailer::DELETED
        Retailer.where(id: @sale.retailer.id).update_all status: Retailer::ADDED
      end
      render :show, status: :ok
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  def update
    sale = sale_params
    sale[:status] = Sale::MODIFIED

    # TODO: 後でDRYにする
    unless sale[:edited_at].nil?
      before_edited_at = Sale.find(@sale.id).edited_at
      if !before_edited_at.nil? and sale[:edited_at] <= before_edited_at
        sale[:edited_at] = before_edited_at
      end
    end

    if @sale.update(sale)
      if @sale.retailer.status == Retailer::DELETED
        Retailer.where(id: @sale.retailer.id).update_all status: Retailer::MODIFIED
      end
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
    params.permit(:amount, :status, :retailer_id, :created_at, :updated_at, :edited_at)
  end
end
