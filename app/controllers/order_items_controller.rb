class OrderItemsController < ApplicationController
  before_action :find_cart, only: %i(index create)
  before_action :find_order 
  def show
    @order_item = OrderItem.find(params[:id])
  end

  def index
    @order_items = @order.order_items
  end

  def new 
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new
    @cart.cart_items.each do |cart_item|
      @order_item.product_name = cart_item.product.name
      @order_item.product_price = cart_item.product.price
      @order_item.quantity = cart_item.quantity
      @order_item.total = cart_item.total
      @order_item.order_id = @order.id
    end
   
    if @order_item.save
      @order.update name: @order_item.name
      @order.update total_price: @order.order_items.sum(:total)
      redirect_to root_path, notice:"order success!"
    else
      render :new, notice: "order fails!"
    end
    binding.pry
  end
  
  def find_cart
    @cart = current_user.cart
    @cart = Cart.create user: current_user unless @cart
  end

  private
  def find_order
    @order = Order.find_or_create_by user_id: current_user.id
  end

  def order_item_params
    params.require(:order_item).permit(:name, :address, :phone,:note)
  end

end
