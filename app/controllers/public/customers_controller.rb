class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end
  
  def edit 
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path
    else
      render :edit
    end
  end
  
  def check
  end
  
  def withdraw
    current_customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
 
  private
  
  def customer_params
    params.require(:customer).permit(
      :last_name,:first_name,:kana_last_name,:kana_first_name,:email,:postal_code,:address,:phone_number)
  end
end
