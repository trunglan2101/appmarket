class CartItemsController < ApplicationController
  
  # def new
  #   @cart_item = CartItem.new
  # end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    
    if @cart_item.save
      redirect_to products_path, notice: "successfuly!"
    else
      redirect_to products_path, notice: "not success"
    end
  end
  def index
    @cart_items = CartItem.where(cart_id: current_user.id)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :total, :product_id, :cart_id)
  end
end
