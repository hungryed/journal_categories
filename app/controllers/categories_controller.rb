class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @new_category = Category.new
  end

  def create
    @new_category = Category.new(category_params)
    if @new_category.save
      redirect_to categories_path, notice: 'Category Added Successfully'
    else
      redirect_to new_category_path, notice: 'That category already exists'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Total Annihilation'
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
