class UsersController < ApplicationController
  def index
    users = User.all.order(:created_at).page(params[:page]).per(params[:size])
    response = {}
    response[:items] = users
    response[:total] = User.count
    render json: response
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

end
