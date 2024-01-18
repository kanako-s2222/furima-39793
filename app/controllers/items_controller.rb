class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_not_user, only: [:edit, :update]
  before_action :sold_out_redirect_user, only: [:edit]

  def index
    @items = Item.includes(:user).order("created_at DESC")
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
    if current_user.id == @item.user.id
      @item.destroy
    end
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
    params.require(:item).permit(:item, :description, :price, :category_id, :status_id, :charge_id, :day_id, :prefecture_id, :image).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def redirect_not_user
    unless current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def sold_out_redirect_user
    if @item.order
      redirect_to root_path
    end
  end
  
end
