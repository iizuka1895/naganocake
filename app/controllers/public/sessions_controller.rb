# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]
  
  def after_sign_in_path_for(resource)
    root_path
  end
  

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private
    # アクティブであるかを判断するメソッド
    def customer_state
      # 【処理内容1】 入力されたemailからアカウントを1件取得
      customer = Customer.find_by(email: params[:customer][:email])
      # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
      return if customer.nil?
      # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
      return unless customer.valid_password?(params[:customer][:password])
      # 【処理内容4】 アクティブでない会員に対する処理
      
      if customer.is_active == false
        redirect_to new_customer_registration_path
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
      else
        flash[:notice] = "ログインに成功しました"
      end  
    end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
