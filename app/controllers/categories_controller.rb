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
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
