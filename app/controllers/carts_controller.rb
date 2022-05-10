class CartsController < ApplicationController
  before_action :find_cart, only: [:update]
  def index
  end

  def new
    @cart = Cart.new
  end

  def update
    ActiveRecord::Base.transaction do
      params[:cart][:cart_items_attributes].values.each do |cart_item_params|
        cart_item = CartItem.find(cart_item_params[:id])
        new_quantity = cart_item_params[:quantity].to_i
        if new_quantity != cart_item.quantity
          cart_item.update! quantity: new_quantity, total: new_quantity * cart_item.product.price
        end
      end
      update_status = @cart.update! total_price: @cart.cart_items.sum(:total)
      if update_status
        redirect_to cart_items_path, notice: "Update cart success!"
      else
        redirect_to cart_items_path, notice: "Update cart fail!"
      end
    rescue Exception => error
      redirect_to cart_items_path, notice: "Update cart fail! #{error}"
    end
  end
  
  def show
  end

  def destroy
    @cart = current_user.cart
    @cart.destroy
    redirect_to products_path
  end

  private
  
  def cart_params
    params.require(:cart)
  end

  def find_cart
    @cart = current_user.cart
    @cart = Cart.create user: current_user unless @cart
  end
end
