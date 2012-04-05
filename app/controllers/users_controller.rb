class UsersController < ApplicationController
  
  before_filter :find_user, :only => [:show]
  before_filter :find_user_for_edit, :only => [:edit, :update]

  def show
    
  end
  
  def edit
  end

  def update
    @user.update_attributes(params[:user])
    if @user.save
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end
  
  protected
  
  def find_user
    @user = User.find_by_id(params[:id])
  end

  def find_user_for_edit
    @user = User.find_by_id(params[:id])
    return render :status => :forbidden unless current_user.can_edit_user?(@user)
  end
end
  
