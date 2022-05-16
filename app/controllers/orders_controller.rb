class OrdersController < ApplicationController
  before_action :find_cart
  def new
    if @cart.cart_items.empty?
      redirect_to products_path, notice:"Cart is empty!!!1"
    end

    @order = Order.new
    @order_item = OrderItem.new
  end

  def create

    @order = Order.new(order_params)
    @order.add_order_items_from_cart(find_cart)
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
  def add_order_items_from_cart(cart)
    @order_item = OrderItem.new
    cart.cart_items.each do |c|
      @order_item.product_name = c.product.name
      @order_item.product_price = c.product.price
      @order_item.quantity = c.quantity
      @order_item.total = c.total
      @order_item.order_id = Order.id
    end
  end
  
  def order_params
    params.require(:order).permit(:name, :address, :phone, :note, :total_price, :user_id)
  end
end
