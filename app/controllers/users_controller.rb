class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def trips
  	@user = User.find(params[:user_id])
  end

  def hosting
  	@user = User.find(params[:user_id])
  end
end
