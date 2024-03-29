class PagesController < ApplicationController
  
  before_filter :find_page_to_edit, :only => [:edit, :update, :destroy]
  before_filter :find_page_to_view, :only => [:show]
  
  def new
    @page = Page.new
    @version = @page.versions.build(:version => 1)
  end 
  
  def create
    @page = Page.new(:owner => current_user)
    @page.versions.build(:title => params[:title], :content => params[:content], :version => params[:version])
    @page.actions.build(:user => current_user, :action => 'create')
    if @page.save
      redirect_to page_path(@page)
    else
      render :action => :new
    end
  end
  
  def update
    params[:version] = params[:version].to_i + (params[:new_version] ? 1 : 0)
    @page.versions.build(:title => params[:title], :content => params[:content], :version => params[:version])
    Action.create_action(:action => 'update', :user => current_user, :page => @page)
    if @page.save
      redirect_to page_path(@page)
    else
      render :action => :edit
    end
  end
  
  def show
    Action.create_action(:action => 'view', :user => current_user, :page => @page)
    @version = @page.latest_version
    @actions = @page.actions
    @comments = @page.comments
  end
  
  def edit
    @version = @page.latest_version
  end

  def destroy
    Action.create_action(:action => 'destroy', :user => current_user, :page => @page)
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
  
