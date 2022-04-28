class CartsController < ApplicationController
  def index
    @carts = Cart.where(cart_id: current_user.id)
  end

  def new
    @cart = Cart.new
  end
  
  def show
  end
end
