class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :new, :update]
  PER_PAGE = 2
  def index
    # @categories = Category.all
    
    # cate = params[:cate]

    # if !cate.nil?
    #   @products = Product.where(:category_id => cate)

    # else
    #   @products = Product.paginate(page: params[:page],per_page: PER_PAGE).order("created_at desc")

    # end

    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  # def search
  #   @products = Product.where("name LIKE ?", "%" + params[:q] + "%")
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
