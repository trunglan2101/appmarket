class OrderItemsController < ApplicationController
  before_action :find_cart, only: %i(new index create)
  before_action :find_order 
  def show
    @order_item = OrderItem.find(params[:id])
  end

  def index
    @order_items = OrderItem.all
  end

  def new 
    @order_item = OrderItem.new
    # @order_items = @cart.cart_items
  end

def create
    @order_item = OrderItem.new(order_item_params)
    @cart.cart_items.each do |cart_item|
      @order_item.update product_name: cart_item.product.name,
                        product_price: cart_item.product.price,
                        quantity: cart_item.quantity,
                        total: cart_item.total,
                        order_id: @order.id
      if @order_item.save
        @order.update name: @order_item.name
        @order.update total_price: @order.order_items.sum(:total)
        @cart.destroy
        redirect_to root_path, notice:"order success!"
      else
        render :new, notice: "order fails!"
      end
      binding.pry
    end
                        
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
    params.require(:order_item).permit(:image, :product_name, :product_price,:quantity, :total, :order_id)
  end

end
