class UsersController < ApplicationController
  before_filter :must_be_team_member

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
