class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_index, only: :index

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      # logger.debug @order_address.errors.full_messages
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def move_to_index
    return unless params[:item_id].present?

    @item = Item.find(params[:item_id])
    if @item.order.present?
      redirect_to root_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  # 追加メソッド
  def authenticate_user_for_purchase
    return if user_signed_in?

    redirect_to new_user_session_path, alert: 'ログインが必要です。'
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :place_id, :city, :street, :building, :phone_number, :image,:token).merge(user_id: current_user.id,item_id: params[:item_id],token:params[:token] )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
