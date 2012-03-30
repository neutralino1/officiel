class PagesController < ApplicationController
  
  before_filter :set_page, :only => [:show, :edit, :update]
  
  def new
    @page = Page.new
  end 
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to page_path(@page)
    else
      render :action => :new
    end
  end
  
  def update
    @page.update_attributes(params[:page])
    if @page.save
      redirect_to page_path(@page)
    else
      render :action => :edit
    end
  end
  
  def show
  end
  
  def edit
  end
  
  protected
  
  def set_page
    @page = Page.find_by_id(params[:id])
  end
end
  
