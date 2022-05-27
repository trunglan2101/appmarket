class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to category_path
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def import
    ActiveRecord::Base.transaction do
      file = params[:category][:file]
      CSV.foreach(file.path, headers: true) do |row|
        # Category.new
        Category.create!(row.to_hash)
      end
      redirect_to categories_path, notice: "Import category success!"
    end
    rescue Exception => error
      redirect_to categories_path, notice: "Import category  fail!"
  end

  private
  
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
