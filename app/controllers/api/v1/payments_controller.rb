class Api::V1::PaymentsController < ApplicationController
  before_action :set_payment, only: %i(show update destroy)

  def index
    if params[:updated_after]
      @payments = Payment.status(params[:status]).where('updated_at >= ?', params[:updated_after])
    else
      @payments = Payment.status(params[:status])
    end
  end

  def show
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.status = Payment::ADDED
    if @payment.save
      render :show, status: :ok
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def update
    payment = payment_params
    payment[:status] = Payment::MODIFIED

    # TODO: 後でDRYにする
    unless payment[:edited_at].nil?
      before_edited_at = Payment.find(@payment.id).edited_at
      if !before_edited_at.nil? and payment[:edited_at] <= before_edited_at
        payment[:edited_at] = before_edited_at
      end
    end

    if @payment.update(payment)
      render :show, status: :ok
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @payment.status = Payment::DELETED
    if @payment.save
      render :show, status: :ok
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  private
  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.permit(:amount, :status, :sale_id, :created_at, :updated_at, :edited_at)
  end
end
