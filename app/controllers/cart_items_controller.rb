class CartItemsController < ApplicationController
  before_action :find_cart, only: %i(index create)

  def index
    @cart_items = @cart.cart_items
  end

  def create
    @cart_item = @cart.cart_items.find_by(product_id: cart_item_params[:product_id])
    if @cart_item 
      @cart_item.quantity += 1
      @cart_item.total = @cart_item.total + cart_item_params[:total].to_i
    else
      @cart_item = CartItem.new(cart_item_params)
    end

    if @cart_item.save
      @cart.update total_price: @cart.cart_items.sum(:total)

      redirect_to products_path, notice: "add gio hang thanh cong"
    else
      redirect_to products_path, notice: "add gio hang that bai"
    end
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

  def find_cart
    @cart = current_user.cart
    @cart = Cart.create user: current_user unless @cart
  end
end
