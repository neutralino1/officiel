class PermissionsController < ApplicationController
  def create
    @page = Page.find(params[:page_id])
    klass, id = params[:entity_id].split('_')
    entity = klass.capitalize.constantize.find(id)
    @page.permissions.create({:entity => entity, :rights => params[:rights]})
    render :partial => 'pages/permissions'
  end

  def destroy
    permission = Permission.find(params[:id])
    @page = permission.page
    permission.destroy
    render :partial => 'pages/permissions'
  end
end
