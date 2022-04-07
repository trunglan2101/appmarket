class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :new, :update]

  def index
    @categories = Category.all
    
    cate = params[:cate]
    @q = Product.ransack(params[:q])
  
    if !cate.nil?
      @products = Product.where(:category_id => cate)
      @products = Kaminari.paginate_array(@products).page(params[:page])
    elsif !@q.nil?
      @products = @q.result(distinct: true)
      @products = Kaminari.paginate_array(@products).page(params[:page]).per(1)
    else
      @products = Product.page(params[:page]).order("created_at desc")
    end
  end

  # def search
  #   @products = Product.where("name LIKE ?", "%#{params[:q]}%")
  #   # binding.pry
  # end

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

  private
  def product_params
    params.require(:product).permit(:name, :image, :description, :price, :category_id)
  end
end
