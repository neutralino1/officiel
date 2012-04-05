# -*- coding: utf-8 -*-
class TeamsController < ApplicationController
  before_filter :can_create, :only => [:new, :create]
  before_filter :find_team_for_edit, :only => [:add, :remove]
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    team = Team.create(params[:team])
    redirect_to teams_path
  end

  def add
    @user = User.find(params[:user_id])
    @team.users << @user
    render :partial => 'users/user_teams'
  end

  def remove
    @user = User.find(params[:user_id])
    @team.users.delete(@user)
    render :partial => 'users/user_teams'
  end

  protected
  
  def can_create
    return render :forbidden unless current_user.can_create_team?
  end

  def find_team_for_edit
    @team = Team.find(params[:id])
    return render :forbidden unless current_user.can_edit_team?(@team)
  end
end
