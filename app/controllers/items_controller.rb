class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_not_user, only: [:edit, :update]
  before_action :sold_out_redirect_user, only: [:edit]
  before_action :prevent_edit_sold_item, only: [:edit]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @item.destroy if current_user.id == @item.user.id
    redirect_to root_path
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :explain, :category_id, :condition_id, :delivery_price_id, :place_id,
                                 :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def redirect_not_user
    return if current_user.id == @item.user.id

    redirect_to root_path
  end

  def sold_out_redirect_user
    return unless @item.order

    redirect_to root_path
  end

  def prevent_edit_sold_item
    return unless current_user && @item.order.present?

    redirect_to root_path
  end
end
