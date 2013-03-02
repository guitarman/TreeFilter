class CategoriesController < ApplicationController
  def index
    @categories = Category.search(params[:search])

    respond_to do |format|
      format.html #index.html.erb
      format.xml { render :xml => @categories }
    end
  end
end
