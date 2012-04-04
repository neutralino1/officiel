class PermissionsController < ApplicationController
  def create
    @page = Page.find(params[:page_id])
    user = User.find(params[:user_id])
    @page.permissions.create({:user => user, :rights => params[:rights]})
    render :partial => 'pages/permissions'
  end

  def destroy
    permission = Permission.find(params[:id])
    @page = permission.page
    permission.destroy
    render :partial => 'pages/permissions'
  end
end
