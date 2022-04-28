class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :edit, :new, :update]
  
  def index
    @categories = Category.all
    
    cate = params[:cate]
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page])
    @products = @products.where(category_id: cate) if cate.present?
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to products_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :image, :description, :price, :category_id)
  end
end
