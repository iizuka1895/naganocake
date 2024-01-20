class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
   @order = Order.includes(:order_details).all.page(params[:page])
  end


  private
    def order_params
      params.require(:order).permit(:customer_id, :name, :post_code, :adress, :postage, :payment, :method_of_payment, :quantity)
    end
end
