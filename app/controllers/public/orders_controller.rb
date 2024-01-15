class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    
  end
  
  def new
    @order = Order.new
    @order_details = @order.order_details
  end
  
  def confirm
    @cart_items = current_customer.cart_items
 
    #自宅
    if params[:order][:my_adress] == "1"
      @order = Order.new
      @order.post_code = current_customer.postal_code
      @order.adress = current_customer.adress
      @order.name = current_customer.first_name + current_customer.last_name
      @order.method_of_payment = params[:order][:method_of_payment]
    #新規登録
    elsif params[:order][:my_adress] == "2"
      @order = Order.new(order_params)
    else
      render 'new'
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    
    #order_itemの保存
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.quantity = cart_item.amount
      @order_detail.tax_included_price = cart_item.item.add_tax_price
      @order_detail.order_id = @order.id
      @order_detail.save
    end
    #カートの中身を削除
    current_customer.cart_items.destroy_all
    redirect_to thanx_public_orders_path
  end
  
  
  private
    def order_params
      params.require(:order).permit(:customer_id, :name, :adress, :post_code, :postage, :payment, :method_of_payment)
    end
end
