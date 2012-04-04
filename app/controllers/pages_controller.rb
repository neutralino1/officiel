class PagesController < ApplicationController
  
  before_filter :find_page_to_edit, :only => [:edit, :update, :destroy]
  before_filter :find_page_to_view, :only => [:show]
  
  def new
    @page = Page.new
  end 
  
  def create
    @page = Page.new(params[:page].merge(:owner => current_user))
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
    @users = User.all
    @editors = @page.editors
    @non_editors = @users - @editors - [current_user]
    @viewers = @page.viewers
    @non_viewers = @users - @editors - @viewers - [current_user]
  end
  
  def edit
  end

  def destroy
    @page.destroy
    redirect_to root_path
  end
  
  protected

  def find_page_to_view
    @page = Page.find(params[:id])
    return render :status => :forbidden unless current_user.can_view_page?(@page)
  end

  def find_page_to_edit
    @page = Page.find(params[:id])
    return render :status => :forbidden unless current_user.can_edit_page?(@page)
  end
end
  
