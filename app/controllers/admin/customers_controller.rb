class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page])
  end

  def show
    @customers = Customer.find(params[:id])
  end

  def edit
    @customers = Customer.find(params[:id])
  end

  def update
    @customers = Customer.find(params[:id])
    if @customers.update(customer_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to admin_customer_path
    else
      render 'edit'
    end
  end

  private
   def customer_params
     params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :adress, :telephone_number, :email, :is_active)
   end
end