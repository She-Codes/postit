class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(post_params)

    if @category.save
      flash[:notice] = "Your category was created."
      redirect_to categories_path
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:category).permit(:name)
  end

end