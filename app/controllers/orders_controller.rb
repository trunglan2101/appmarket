class OrdersController < ApplicationController
  before_action :find_cart
  def index
    @orders = Order.all
  end
  def new
    if @cart.cart_items.empty?
      redirect_to products_path, notice:"Cart is empty!!!1"
    end

    @order = Order.new
    # @order_item = OrderItem.new
  end

  def create

    @order = Order.new(order_params)
    @order_item = @order.order_items.new
    @cart.cart_items.each do |cart|
      @order_item.update  product_name: cart.product.name, product_price: cart.product.price, quantity: cart.quantity, total: cart.total, order_id: @order.id
    end
    if @order.save
      @order.update total_price: @cart.cart_items.sum(:total)
      @cart.destroy
      redirect_to root_path, notice:"order thanh cong"
    else
      render :new, notice:"order that bai"
    end
  end

  def find_cart
    @cart = current_user.cart
    @cart = Cart.create user: current_user unless @cart
  end

  
  private
  
  def order_params
    params.require(:order).permit(:name, :address, :phone, :note, :total_price, :user_id)
  end
end
